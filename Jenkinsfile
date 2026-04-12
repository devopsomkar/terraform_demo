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
                script {
                    withCredentials([
                        string(credentialsId: 'dynatrace-token', variable: 'DYNA_TOKEN'),
                        string(credentialsId: 'dynatrace-tenant', variable: 'DYNA_TENANT')
                    ]) {
                        bat '''
                            terraform plan ^
                            -var="key_name=null" ^
                            -var="dynatrace_tenant=%DYNA_TENANT%" ^
                            -var="dynatrace_token=%DYNA_TOKEN%" ^
                            -out=tfplan
                        '''
                        archiveArtifacts artifacts: 'tfplan', allowEmptyArchive: false
                    }
                }
            }
        }

        stage('Approval') {
            steps {
                input message: 'Apply changes? Check plan artifact.'
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    withCredentials([
                        string(credentialsId: 'dynatrace-token', variable: 'DYNA_TOKEN'),
                        string(credentialsId: 'dynatrace-tenant', variable: 'DYNA_TENANT')
                    ]) {
                        bat '''
                            terraform apply ^
                            -var="key_name=null" ^
                            -var="dynatrace_tenant=%DYNA_TENANT%" ^
                            -var="dynatrace_token=%DYNA_TOKEN%" ^
                            tfplan
                        '''
                    }
                }
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
