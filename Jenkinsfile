pipeline {
    agent any

    environment {
        KUBECONFIG = '/var/jenkins_home/.kube/config'
        SONAR_HOST_URL = "http://sonarqube:9000"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'prod', url: 'https://github.com/kruthikav04/hello-python.git'
            }
        }

        stage('Code Quality - SonarQube') {
            steps {
                echo 'Running SonarQube Scan'

                withCredentials([string(credentialsId: 'sonar-token', variable: 'SONAR_TOKEN')]) {
                    script {
                        docker.image('sonarsource/sonar-scanner-cli:latest').inside {
                            sh '''
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
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t hello-python:latest .'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    docker.image('bitnami/kubectl:latest').inside {
                        sh 'kubectl apply -f deployment.yaml -n dev'
                    }
                }
            }
        }
    }
}

