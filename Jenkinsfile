pipeline {
    agent any

    environment {
        SONAR_HOST_URL = "http://10.4.4.69:9000"
        IMAGE_NAME     = "hello-python"
        K8S_NAMESPACE  = "dev"
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Checking out code from Git'
                git branch: 'prod',
                    url: 'https://github.com/kruthikav04/hello-python.git'
            }
        }

        stage('Code Quality - SonarQube') {
            steps {
                echo 'Running SonarQube Scan'
                withCredentials([
                    string(credentialsId: 'Sonar-token', variable: 'SONAR_TOKEN')
                ]) {
                    sh '''
                        docker run --rm \
                          -e SONAR_HOST_URL=$SONAR_HOST_URL \
                          -e SONAR_TOKEN=$SONAR_TOKEN \
                          -v "$PWD:/usr/src" \
                          -v /tmp:/tmp \
                          sonarsource/sonar-scanner-cli:latest \
                          sonar-scanner \
                            -Dsonar.projectKey=hello-python \
                            -Dsonar.projectName=hello-python \
                            -Dsonar.sources=. \
                            -Dsonar.host.url=$SONAR_HOST_URL
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
                withCredentials([
                    file(credentialsId: 'kubeconfig-dev', variable: 'KUBECONFIG')
                ]) {
                    sh '''
                        kubectl get nodes
                        kubectl apply -f deployment.yaml -n dev
                        kubectl rollout status deployment/python-app -n dev
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
            echo '✅ Pipeline succeeded!'
        }
        failure {
            echo '❌ Pipeline failed. Please check the logs!'
        }
    }
}
