pipeline {
    agent any

    environment {
        TF_IN_AUTOMATION = "true"
        TF_INPUT = "false"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/kruthikav04/hello-python.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                    docker build -t hello-python:latest .
                '''
            }
        }

        /*
        stage('Create Namespace dev') {
            steps {
                sh '''
                    kubectl get namespace dev || kubectl create namespace dev
                '''
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                    kubectl apply -f k8s/deployment.yml -n dev
                '''
            }
        }
        */

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                dir('terraform') {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform') {
                    sh 'terraform plan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh 'terraform apply'
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
        success {
            echo '✅ Pipeline succeeded! Terraform created dev namespace.'
        }
        failure {
            echo '❌ Pipeline failed. Check logss.'
        }
    }
}
