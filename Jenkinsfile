pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                echo 'Checking out code from Git'
                git branch: 'prod', url: 'https://github.com/kruthikav04/hello-python.git'
            }
        }

        stage('Code Quality - SonarQube') {
            steps {
                echo 'Running SonarQube Scan using Docker'
                withCredentials([string(credentialsId: 'Sonar-token', variable: 'SONAR_TOKEN')]) {
                    sh '''
                        docker run --rm \
                            -e SONAR_TOKEN=$SONAR_TOKEN \
                            -v $(pwd):/usr/src \
                            sonarsource/sonar-scanner-cli:latest \
                            sonar-scanner \
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
                        # Use kubeconfig file from Jenkins credentials
                        export KUBECONFIG=$KUBECONFIG

                        # Apply Kubernetes manifests
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
