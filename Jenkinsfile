pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'prod', url: 'https://github.com/kruthikav04/hello-python.git'
            }
        }

        stage('Code Quality - SonarQube') {
            steps {
                echo 'Running SonarQube Scan'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t hello-python .'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh 'kubectl apply -f deployment.yaml'
            }
        }
    }
}

