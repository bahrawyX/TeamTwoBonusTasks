pipeline { 
    agent any

    environment {
        // Docker and AWS Configuration
        DOCKER_IMAGE = "xbahrawy/finalproject"
        TERRAFORM_DIR = "${terraform}"
        AWS_DIR = "${aws}"
        KUBECTL_DIR = "${kubectl}"
        DOCKER_CREDENTIALS = '135feaae-4bb5-4233-8869-4cf8939df9ed'
        AWS_CREDENTIALS = 'fd08b267-20f1-422b-b2cf-a2f446f18839'
        TERRAFORM_CONFIG_PATH = "${env.WORKSPACE}\\terraform"
        KUBECONFIG_PATH = "${env.WORKSPACE}\\kubeconfig"
        K8S_DIR = "${env.WORKSPACE}\\K8S"
    }

    stages {
        stage('CI PIPELINE') {
            parallel {
                stage('Clone Git Repository') {
                    steps {
                        echo "Cloning the Git repository"
                        // Add your git clone command here if needed
                    }
                }

                stage('Install Grype') {
                    steps {
                        script {
                            powershell '''
                            Invoke-WebRequest -Uri https://raw.githubusercontent.com/anchore/grype/main/install.sh -OutFile grype-install.sh
                            bash .\\grype-install.sh -b C:\\Windows\\System32
                            grype version
                            '''
                        }
                    }
                }

                stage('Build Docker Image') {
                    steps {
                        script {
                            // Build the Docker image with the build number as the tag
                            docker.build("${DOCKER_IMAGE}:${env.BUILD_NUMBER}")
                        }
                    }
                }

                stage('SonarQube Analysis') {
                    steps {
                        withSonarQubeEnv('SONARQUBE') { 
                            script {
                                def outputFile = "${env.WORKSPACE}\\sonarqube-analysis-output.txt"
                                // Run SonarQube analysis and redirect output to a file
                                bat "C:\\sonar-scanner\\bin\\sonar-scanner.bat -Dsonar.projectKey=TeamTwoProject -Dsonar.sources=. -Dsonar.host.url=http://localhost:9000 -Dsonar.login=sqp_ac3e939a14240d3a85148fa7f97d9dfb46b02789 > ${outputFile}"
                                // Optionally, print the file content in the console
                                bat "type ${outputFile}"
                            }
                        }
                    }
                }

                stage('Load Testing Check') {
                    steps {
                        script {
                            bat 'k6 run load_test.js'
                        }
                    }
                }
            }
        }

        stage('CD PIPELINE') {
            stages {
                stage('Push Docker Image to Docker Hub') {
                    steps {
                        script {
                            echo "Pushing Docker image ${DOCKER_IMAGE}:${env.BUILD_NUMBER} to Docker Hub"
                            withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS}", passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                                bat """
                                echo Logging into Docker Hub...
                                docker login -u %DOCKER_USERNAME% -p %DOCKER_PASSWORD%
                                docker tag ${DOCKER_IMAGE}:${env.BUILD_NUMBER} ${DOCKER_IMAGE}:latest
                                docker push ${DOCKER_IMAGE}:${env.BUILD_NUMBER}
                                docker push ${DOCKER_IMAGE}:latest
                                """
                            }
                        }
                    }
                }

                stage('Terraform Init') {
                    steps {
                        script {
                            // Initialize Terraform in the specified configuration path
                            dir("${env.TERRAFORM_CONFIG_PATH}") {
                                bat """${env.TERRAFORM_DIR} init"""
                            }
                        }
                    }
                }

                stage('Terraform Plan') {
                    steps {
                        script {
                            // Generate and show the Terraform execution plan
                            dir("${env.TERRAFORM_CONFIG_PATH}") {
                                bat """${env.TERRAFORM_DIR} plan"""
                            }
                        }
                    }
                }

                /*
                Uncomment the following stage when you are ready to apply the Terraform plan
                stage('Terraform Apply') {
                    steps {
                        script {
                            // Apply the Terraform plan to deploy the infrastructure
                            dir("${env.TERRAFORM_CONFIG_PATH}") {
                                bat """${env.TERRAFORM_DIR} apply -auto-approve"""
                            }
                        }
                    }
                }
                */

                stage('Verify Kubeconfig Path') {
                    steps {
                        script {
                            echo "KUBECONFIG path is set to: ${env.KUBECONFIG_PATH}"
                            bat "kubectl config view --kubeconfig ${KUBECONFIG_PATH}"
                        }
                    }
                }

                stage('Update Kubeconfig') {
                    steps {
                        script {
                            withCredentials([usernamePassword(credentialsId: "${AWS_CREDENTIALS}", usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                                bat """
                                set AWS_ACCESS_KEY_ID=%AWS_ACCESS_KEY_ID%
                                set AWS_SECRET_ACCESS_KEY=%AWS_SECRET_ACCESS_KEY%
                                set AWS_DEFAULT_REGION=us-east-2
                                
                                aws eks --region %AWS_DEFAULT_REGION% update-kubeconfig --name team2_cluster --kubeconfig ${KUBECONFIG_PATH}
                                """
                            }
                        }
                    }
                }

                stage('Deploy Kubernetes Resources') {
                    steps {
                        script {
                            withCredentials([usernamePassword(credentialsId: "${AWS_CREDENTIALS}", usernameVariable: 'AWS_ACCESS_KEY_ID', passwordVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                                bat """
                                set AWS_ACCESS_KEY_ID=%AWS_ACCESS_KEY_ID%
                                set AWS_SECRET_ACCESS_KEY=%AWS_SECRET_ACCESS_KEY%
                                
                                kubectl --kubeconfig ${KUBECONFIG_PATH} apply -f ${K8S_DIR}\\namespace.yaml
                                kubectl --kubeconfig ${KUBECONFIG_PATH} apply -f ${K8S_DIR}\\pv.yaml
                                kubectl --kubeconfig ${KUBECONFIG_PATH} apply -f ${K8S_DIR}\\pvc.yaml
                                kubectl --kubeconfig ${KUBECONFIG_PATH} apply -f ${K8S_DIR}\\deployment.yaml
                                kubectl --kubeconfig ${KUBECONFIG_PATH} apply -f ${K8S_DIR}\\service.yaml
                                """
                            }
                        }
                    }
                }

                stage('Deploy Prometheus and Grafana') {
                    steps {
                        script {
                            bat """
                            kubectl --kubeconfig ${KUBECONFIG_PATH} apply -f ${K8S_DIR}/prometheus-config.yaml
                            kubectl --kubeconfig ${KUBECONFIG_PATH} apply -f ${K8S_DIR}/prometheus-deployment.yaml
                            kubectl --kubeconfig ${KUBECONFIG_PATH} apply -f ${K8S_DIR}/prometheus-service.yaml
                            kubectl --kubeconfig ${KUBECONFIG_PATH} apply -f ${K8S_DIR}/grafana-deployment.yaml
                            kubectl --kubeconfig ${KUBECONFIG_PATH} apply -f ${K8S_DIR}/grafana-service.yaml
                            kubectl --kubeconfig ${KUBECONFIG_PATH} apply -f ${K8S_DIR}/alertmanager-deployment.yaml
                            kubectl --kubeconfig ${KUBECONFIG_PATH} apply -f ${K8S_DIR}/alertmanager-service.yaml
                            kubectl --kubeconfig ${KUBECONFIG_PATH} apply -f ${K8S_DIR}/servicemonitor.yaml
                            kubectl --kubeconfig ${KUBECONFIG_PATH} apply -f ${K8S_DIR}/servicemonitor.yaml
                            """
                        }
                    }
                }

                stage('Port Forward Prometheus and Grafana') {
                    steps {
                        script {
                            // Port forwarding Prometheus and Grafana to the local machine
                            bat """
                            start kubectl --kubeconfig ${KUBECONFIG_PATH} port-forward svc/prometheus 9090:9090 -n teamtwo-namespace
                            start kubectl --kubeconfig ${KUBECONFIG_PATH} port-forward svc/grafana 3000:3000 -n teamtwo-namespace
                            """
                        }
                    }
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline completed with or without failures."
        }
        success {
            echo 'Pipeline completed successfully.'
        }
        failure {
            echo "Pipeline failed. Please review the logs for more information."
        }
    }
}
