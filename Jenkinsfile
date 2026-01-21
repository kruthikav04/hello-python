pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                echo 'Checking out code from Git'
                git branch: 'prod', url: 'https://github.com/kruthikav04/hello-python.git'
            }
        }

        stage('SonarQube Scan') {
            steps {
                echo 'Running SonarQube Scan'
                withCredentials([string(credentialsId: 'Sonar-token', variable: 'SONAR_TOKEN')]) {
                    sh '''
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
                        export KUBECONFIG=$KUBECONFIG
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
