
# Project Setup and Execution Guide

## Step 1: Run the Flask Application

First, we need to set up and run the Flask application locally.

### Code to Set Up the Flask Environment

\`\`\`bash
# Step 1.1: Install Python Dependencies
pip install -r requirements.txt

# Step 1.2: Run the Flask Application
python lms.py
\`\`\`

This will start the Flask application locally on `http://localhost:5000`.

---

## Step 2: Dockerize the Application

Next, we'll containerize the application using Docker.

### Code to Build and Run the Docker Container

\`\`\`bash
# Step 2.1: Build the Docker Image
docker build -t library-management-system .

# Step 2.2: Run the Docker Container
docker run -d -p 5000:5000 library-management-system
\`\`\`

This command builds a Docker image for the application and runs it in a container.

---

## Step 3: Deploy the Application on Kubernetes (EKS)

Now, we will deploy the containerized application on an AWS EKS cluster.

### Code to Apply Kubernetes Configuration

# Step 3.1: Apply Kubernetes Configuration Files With All The promethues And Grafana
\`\`\`bash
kubectl create namespace  teamtwo-namespace
kubectl apply -f namespace.yaml
kubectl apply -f pv.yaml
kubectl apply -f pvc.yaml
kubectl apply -f grafana-deployment.yaml
kubectl apply -f grafana-service.yaml
kubectl apply -f prometheus-config.yaml
kubectl apply -f prometheus-deployment.yaml
kubectl apply -f prometheus-service.yaml
kubectl apply -f servicemonitor.yaml
kubectl apply -f alerts.yaml
kubectl apply -f alertmanager-service.yaml
kubectl apply -f alertmanager-deployment.yaml
\`\`\`

This will deploy the application on your Kubernetes cluster and expose it to the internet.

---
# 3.2 **Access Prometheus**:

   Access Prometheus via the LoadBalancer IP or DNS:

   ```url
   http://<LoadBalancer-IP>:9090
   ```
# 3.3 **Access Grafana**:

Access Grafana via the LoadBalancer IP or DNS:

```url
http://<LoadBalancer-IP>:3000

```


## Step 4: Set Up CI/CD Pipeline with Jenkins

Finally, we'll automate the build and deployment process using Jenkins.

### Jenkins Pipeline Code

\`\`\`groovy
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building...'
                sh 'docker build -t library-management-system .'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing...'
                sh 'pytest'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                sh 'kubectl apply -f deployment.yaml'
            }
        }
    }
}
\`\`\`

This Jenkinsfile defines a pipeline with build, test, and deploy stages for automating the deployment of your application.

---
# Project Documentation with Images

## Full System Architecture
![Full System Architecture](../images/Full.png)
- **Our Fully Running Pipeline**: This image represents the overall architecture of our pipeline, showing the integration of various components from the application development stage to deployment, monitoring, and CI/CD automation.

## Docker Overview
![Docker Overview](../images/docker.png)
- **Our Slim Docker Image**: This image illustrates the optimized Docker image used in our project. By utilizing a multi-stage build process and minimizing unnecessary layers, we managed to significantly reduce the image size, making it more efficient for deployment.

## Kubernetes Deployment
![Kubernetes Deployment](../images/grafana.png)
- **Our Grafana Dashboard Image**: This Grafana dashboard provides a visual representation of the metrics collected by Prometheus. It gives insights into various performance aspects of the deployed application, helping us monitor system health and performance.

## Jenkins on EC2
![Jenkins on EC2](../images/jeninsEC2.png)
- **Our Running Jenkins on EC2**: This image captures the Jenkins instance running on an AWS EC2 instance. Jenkins is the backbone of our CI/CD pipeline, automating the process from code commit to deployment on the Kubernetes cluster.

## Load Testing with K6
![K6 Load Testing](../images/k6.png)
- **Our Load Tester**: This image shows the results of load testing conducted using K6. By simulating high traffic scenarios, K6 helps ensure that our application can handle the expected load without performance degradation.

## Terraform Vulnerability and Code Quality Testing
![Terrascan Output](../images/terrascan.png)
![Terrascan Output 2](../images/terrascan2.png)
- **Our Terraform Security Scans**: These images display the output of Terrascan, a tool used to scan our Terraform code for vulnerabilities and compliance issues. Ensuring that our infrastructure-as-code is secure and follows best practices is crucial for the stability and security of our deployment.

## Conclusion
This documentation provides a comprehensive overview of our project, highlighting key stages such as Dockerization, Kubernetes deployment, CI/CD pipeline setup, and monitoring. The images included offer visual insights into the tools and processes we utilized to achieve a robust and scalable application deployment.

### Container Security with Grype
Grype was employed to scan Docker images for vulnerabilities, ensuring that the containers are secure before deployment.

![Grype Security Scan](../images/grype.png)

Return to [Main Documentation](README.md).
