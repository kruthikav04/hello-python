pipeline {
    agent any

    environment {
        APP_NAME    = "hello-python"
        IMAGE_NAME  = "hello-python"
        IMAGE_TAG   = "latest"
        SONAR_HOST  = "http://sonarqube:9000"
    }

    options {
        timestamps()
    }

    stages {

        stage('Checkout Source Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/kruthikav04/hello-python.git'
            }
        }

        stage('Code Quality - SonarQube') {
            steps {
                echo "Running SonarQube analysis (placeholder)"
                // Real scan can be added once sonar-scanner is installed
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '''
                echo "Docker version:"
                docker version

                echo "Building Docker image..."
                docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                '''
            }
        }

        stage('Verify Kubernetes Access') {
            steps {
                sh '''
                echo "Kubectl version:"
                kubectl version --client

                echo "Kubernetes nodes:"
                kubectl get nodes
                '''
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                echo "Applying Kubernetes manifests..."
                kubectl apply -f deployment.yaml

                echo "Checking rollout status..."
                kubectl rollout status deployment/${APP_NAME}
                '''
            }
        }
    }

    post {
        success {
            echo "✅ CI/CD Pipeline executed successfully!"
        }
        failure {
            echo "❌ CI/CD Pipeline failed. Check logs above."
        }
    }
}

