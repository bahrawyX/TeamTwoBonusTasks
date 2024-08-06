
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

Return to [Main Documentation](README.md).
