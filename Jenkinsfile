pipeline {
    agent any

    environment {
        // You can set global environment variables here if needed
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Checking out code from Git'
                git branch: 'prod', url: 'https://github.com/kruthikav04/hello-python.git'
            }
        }

        stage('Code Quality - SonarQube') {
            steps {
                echo 'Running SonarQube Scan'
                withCredentials([string(credentialsId: 'Sonar-token', variable: 'SONAR_TOKEN')]) {
                    sh '''
                        # Run Sonar scanner using Docker
                        docker run --rm \
                            -v $(pwd):/usr/src \
                            sonarsource/sonar-scanner-cli:latest \
                            -Dsonar.projectKey=hello-python \
                            -Dsonar.projectName=hello-python \
                            -Dsonar.sources=. \
                            -Dsonar.login=$SONAR_TOKEN
                    '''
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image'
                sh 'docker build -t hello-python:latest .'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo 'Deploying to Kubernetes'
                withCredentials([file(credentialsId: 'kubeconfig-dev', variable: 'KUBECONFIG')]) {
                    sh '''
                        # Ensure KUBECONFIG environment variable is set
                        export KUBECONFIG=$KUBECONFIG
                        # Apply Kubernetes deployment
                        kubectl apply -f deployment.yaml -n dev
                    '''
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished. Check logs for details.'
        }
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed. Please check the logs!'
        }
    }
}
