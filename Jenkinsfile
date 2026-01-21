pipeline {
    agent any

    // Environment variables
    environment {
        SONAR_HOST_URL = "http://10.4.4.69:9000"
        KUBECONFIG = '/var/jenkins_home/.kube/config'
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

                withCredentials([string(credentialsId: 'sonar-token', variable: 'SONAR_TOKEN')]) {
                    sh '''
                        docker run --rm \
                            -e SONAR_HOST_URL=$SONAR_HOST_URL \
                            -e SONAR_TOKEN=$SONAR_TOKEN \
                            -v /tmp:/tmp \
                            sonarsource/sonar-scanner-cli:latest \
                            sonar-scanner \
                                -Dsonar.projectKey=hello-python \
                                -Dsonar.projectName=hello-python \
                                -Dsonar.sources=. \
                                -Dsonar.language=py \
                                -Dsonar.host.url=$SONAR_HOST_URL \
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
                sh '''
                    docker run --rm \
                        -v $KUBECONFIG:$KUBECONFIG \
                        -v $(pwd):/workspace \
                        -w /workspace \
                        bitnami/kubectl:latest \
                        kubectl apply -f deployment.yaml -n dev
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Please check the logs!'
        }
    }
}
