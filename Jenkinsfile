pipeline {
    agent any

    stages {

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
                    kubectl apply -f deployment.yaml -n dev
                '''
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed. Check logs.'
        }
    }
}
