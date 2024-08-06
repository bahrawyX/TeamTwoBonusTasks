# **Team Two Project Documentation**

## Overview
- The Library Management System is a full-stack application built using Flask. It allows users to manage books in a library, including adding, removing, borrowing, and returning books.

## **Project Overview**
This project is designed to give hands-on experience with a complete software development lifecycle, from application creation to deployment in a cloud environment using various DevOps tools and practices.


## **Table of Contents**
- [**Team Two Project Documentation**](#team-two-project-documentation)
  - [Overview](#overview)
  - [**Project Overview**](#project-overview)
  - [**Table of Contents**](#table-of-contents)
  - [Technology Stack](#technology-stack)
  - [Project Requirments](#project-requirments)
  - [Project Bonus](#project-bonus)
    - [Soft Prerequisites](#soft-prerequisites)
    - [Apps Prerequisites](#apps-prerequisites)
  - [Test Locally](#test-locally)
    - [Project Journey](#project-journey)
  - [**Part 1: Application Development**](#part-1-application-development)
    - [**Objective**](#objective)
    - [**Steps Involved**](#steps-involved)
  - [**Part 2: Dockerization**](#part-2-dockerization)
    - [**Objective**](#objective-1)
    - [**Steps Involved**](#steps-involved-1)
  - [**Part 3: Infrastructure as Code with Terraform**](#part-3-infrastructure-as-code-with-terraform)
    - [**Objective**](#objective-2)
    - [**Steps Involved**](#steps-involved-2)
  - [**Part 4: Kubernetes Deployment on EKS**](#part-4-kubernetes-deployment-on-eks)
    - [**Objective**](#objective-3)
    - [**Steps Involved**](#steps-involved-3)
  - [**Part 5: CI/CD Pipeline Setup**](#part-5-cicd-pipeline-setup)
    - [**Objective**](#objective-4)
    - [**Steps Involved**](#steps-involved-4)
  - [**Part 6: Documentation and Presentation**](#part-6-documentation-and-presentation)
    - [**Objective**](#objective-5)
    - [**Steps Involved**](#steps-involved-5)
  - [Extra Bonus Tasks](#extra-bonus-tasks)
    - [Automated Pipeline](#automated-pipeline)
    - [Load Testing Using K6](#load-testing-using-k6)
    - [Code Quality Using SonarQube](#code-quality-using-sonarqube)
    - [Small Docker Image Size](#small-docker-image-size)
    - [Terraform Unit Testing Using Terratest](#terraform-unit-testing-using-terratest)
    - [Terraform Vulnerability and Code Quality Testing Using Terrascan](#terraform-vulnerability-and-code-quality-testing-using-terrascan)
    - [Security and Vulnerability Scanning Using Grype](#security-and-vulnerability-scanning-using-grype)
    - [Jenkins on EC2](#jenkins-on-ec2)


## Technology Stack
- **Frontend**: HTML, Bootstrap
- **Backend**: Flask (Python)
- **Database**: JSON file (`books.json`)

## Project Requirments 
- **Application Development Using Flask and any Front-End**
- **Dockerization The App**
- **Infrastructure as Code with Terraform**
- **Kubernetes Deployment on EKS**
- **Deploying Every Thing On AWS**
- **CI/CD Pipeline Setup Using Jenkins**

## Project Bonus
- **Set Up Monitoring and Logging Using Grafana And Prometheus**


### Soft Prerequisites
- **Basic Understand Of Git**
- **Basic Understand Of AWS**
- **Knowing How To Deal With CLI**
- **Knowing How To Deal With CLI**

### Apps Prerequisites
- **Kubectl**
- **Terraform**
- **Docker**
- **AWS CLI**
- **Python 3.10+**
- **Jenkins**
- **Java**
- **JavaScript For Some Plugins**
- **Prometheus**
- **Grafana**
- **K6**
- **SonarQube**
- **SonarScanner**
- **Terrascan**
- **Terratest**
- **Grype**
- **Git & GitHub**

## Test Locally
-  **pip install requirements.txt**
-  **python lms.py**
-  
###  Project Journey

## **Part 1: Application Development**

### **Objective**
Develop a simple web application using Python (Flask) that manages library operations such as adding, removing, borrowing, and returning books.

### **Steps Involved**
1. **Set Up a Python Environment**:
   - Install Python 3.6 or higher.
   - Create and activate a virtual environment.
   - Install Flask and other necessary dependencies.

2. **Develop the Flask Application**:
   - Create basic routes for the application.
   - Implement core features like book management (add, remove, search, borrow, return).
   - Ensure the application handles different user interactions smoothly.

3. **Test Locally**:
   - Run the Flask application locally.
   - Ensure all functionalities are working as expected.

4. **Create and Test API Endpoints**:
   - Design RESTful API endpoints for each operation.
   - Test endpoints using tools like Postman.

5. **Prometheus Integration for Monitoring**:
   - Set up basic monitoring using Prometheus client libraries.
   - Expose metrics endpoints.


## **Part 2: Dockerization**

### **Objective**
Containerize the application to make it portable and ensure consistency across different environments.

### **Steps Involved**
1. **Write a Dockerfile**:
   - Define the application environment using a Dockerfile.
   - Ensure dependencies and configurations are correctly set up in the Dockerfile.

2. **Build and Test Docker Image**:
   - Build the Docker image using the Dockerfile.
   - Test the containerized application locally.

3. **Push Docker Image to Docker Hub**:
   - Log in to Docker Hub.
   - Push the built Docker image to a public or private Docker Hub repository for later use in deployments.

4. **Run Application in a Docker Container**:
   - Use Docker commands to run the application in a container.
   - Verify that the application is running as expected inside the container.


## **Part 3: Infrastructure as Code with Terraform**

### **Objective**
Provision an AWS EKS cluster and related infrastructure using Terraform to manage cloud resources in a scalable and repeatable manner.

### **Steps Involved**
1. **Set Up Terraform**:
   - Install Terraform.
   - Configure AWS credentials for Terraform to interact with AWS services.

2. **Write Terraform Configuration Files**:
   - Define the AWS VPC, subnets, and other networking components.
   - Configure an EKS cluster using Terraform modules.
   - Define security groups, IAM roles, and policies for the EKS cluster.

3. **Provision the Infrastructure**:
   - Initialize the Terraform project.
   - Validate the configuration files.
   - Apply the configuration to provision the infrastructure on AWS.

4. **Output and Review Provisioned Resources**:
   - Use Terraform output to review the created resources.
   - Document the resource details for future reference.



## **Part 4: Kubernetes Deployment on EKS**

### **Objective**
Deploy the Dockerized application on the AWS EKS cluster to leverage the scalability and resilience of Kubernetes.

### **Steps Involved**
1. **Prepare Kubernetes Deployment Files**:
   - Create deployment and service YAML files for Kubernetes.
   - Define the desired state of the application, including replicas and resource limits.

2. **Deploy to EKS**:
   - Use `kubectl` to apply the Kubernetes configuration files to the EKS cluster.
   - Verify that the application pods are running and the services are correctly configured.

3. **Implement Kubernetes Configurations**:
   - Set up ConfigMaps and Secrets for configuration management.
   - Implement Horizontal Pod Autoscalers for scaling the application based on load.

4. **Expose the Application**:
   - Use LoadBalancer or Ingress to expose the application to external traffic.
   - Ensure the application is accessible via a public URL.


## **Part 5: CI/CD Pipeline Setup**

### **Objective**
Automate the build, test, and deployment process using a CI/CD pipeline to ensure rapid and reliable delivery of changes.

### **Steps Involved**
1. **Set Up Jenkins**:
   - Install Jenkins and configure necessary plugins.
   - Set up Jenkins credentials for Docker, AWS, and other tools.

2. **Create a Jenkins Pipeline**:
   - Define the Jenkinsfile for the CI/CD pipeline.
   - Implement stages for building the Docker image, running tests, and deploying to EKS.

3. **Integrate Code Quality and Testing Tools**:
   - Integrate SonarQube for code quality checks.
   - Implement load testing using k6.
   - Implement Terratest.

4. **Monitor Pipeline Execution**:
   - Trigger the pipeline on code commits.
   - Monitor the pipeline stages for any issues and ensure successful deployments.


## **Part 6: Documentation and Presentation**

### **Objective**
Document all steps and processes involved in the project to ensure clarity and knowledge sharing.

### **Steps Involved**
1. **Write Detailed Documentation**:
   - Document each part of the project with clear instructions.
   - Include screenshots, diagrams, and code snippets for better understanding.

2. **Use Automated Documentation Tools**:
   - Implement MkDocs or Sphinx to maintain and generate up-to-date documentation.
   - Host the documentation for easy access by team members and stakeholders.

3. **Prepare a Project Presentation**:
   - Summarize the project objectives, processes, and outcomes in a presentation.
   - Include key metrics and results from monitoring and testing phases.

4. **Collaborate and Review**:
   - Set up a collaborative environment for team members to review and contribute to the documentation.
   - Ensure the final documentation is comprehensive and easy to follow.


## Extra Bonus Tasks

### Automated Pipeline
- **Auto-update the Deployment File**: 
  - Set up a CI/CD pipeline that automatically updates deployment files with the latest code changes to ensure smooth and continuous delivery.

### Load Testing Using K6
- **Performance Testing**:
  - Integrate K6 for automated load testing to evaluate application performance under stress and identify potential bottlenecks.

### Code Quality Using SonarQube
- **Static Code Analysis**:
  - Use SonarQube to automatically check your code for bugs, vulnerabilities, and code smells, ensuring high code quality before deployment.

### Small Docker Image Size
- **Optimized Docker Images**:
  - Create a streamlined Docker image to reduce size and improve deployment efficiency by using lightweight base images and multi-stage builds.

### Terraform Unit Testing Using Terratest
- **Infrastructure Testing**:
  - Implement Terratest to write unit tests for your Terraform modules, ensuring your infrastructure is correctly provisioned and error-free.

### Terraform Vulnerability and Code Quality Testing Using Terrascan
- **Security and Compliance**:
  - Use Terrascan to scan Terraform code for security vulnerabilities and ensure compliance with best practices before deployment.

### Security and Vulnerability Scanning Using Grype
- **Container Security**:
  - Employ Grype to scan Docker images for vulnerabilities, ensuring your containers are secure before they are deployed.

### Jenkins on EC2
- **CI/CD Server on AWS**:
  - Deploy Jenkins on an AWS EC2 instance to manage your CI/CD pipeline, providing a scalable and flexible environment for your automation needs.

  For detailed code snippets and images, see [Technical Details](TECHNICAL_DETAILS.md).
