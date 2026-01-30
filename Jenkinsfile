pipeline {
    agent any

    // 🔥 REQUIRED for GitHub webhook trigger
    triggers {
        githubPush()
    }

    options {
        timestamps()
        disableConcurrentBuilds()
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

        stage('Create Namespace dev') {
            steps {
                sh '''
                    kubectl get namespace dev || kubectl create namespace dev
                '''
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo 'Deploying to Kubernetes'
                sh '''
                    kubectl apply -f k8s/deployment.yml -n dev
                '''
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
        success {
            echo '✅ Pipeline succeeded!'
        }
        failure {
            echo '❌ Pipeline failed. Check logs.'
        }
    }
}
