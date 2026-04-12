// Jenkins pipeline for Terraform ECS-EC2-Nginx-Dynatrace
pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID     = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        AWS_DEFAULT_REGION    = 'ap-south-1'  // Your region
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', 
                    url: 'https://github.com/devopsomkar/terraform_demo.git'
            }
        }

        stage('Terraform Init') {
            steps {
                bat 'terraform init -upgrade'
            }
        }

        stage('Terraform Validate') {
            steps {
                bat 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                bat 'terraform plan -var-file="terraform.tfvars" -out=tfplan'
                archiveArtifacts artifacts: 'tfplan', allowEmptyArchive: false
            }
        }

        stage('Approval') {
            steps {
                input message: 'Apply changes? Check plan artifact.'
            }
        }

        stage('Terraform Apply') {
            steps {
                bat 'terraform apply -var-file="terraform.tfvars" tfplan'
            }
        }

        stage('Verify') {
            steps {
                script {
                    // Optional: AWS CLI verify
                    bat '''
                        aws ecs describe-services --cluster my-ecs-cluster --services gft-test-first-services
                    '''
                }
            }
        }
    }

    post {
        always {
            bat 'terraform show'  // State
        }
        cleanup {
            cleanWs()
        }
    }
}
