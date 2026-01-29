pipeline {
    agent any

    stages {

<<<<<<< HEAD
        stage('Checkout') {
            steps {
                git 'https://github.com/kruthikav04/hello-python.git
            }
        }

=======
>>>>>>> 34e5553326f62fb9d55729c016c8729ae21b9df3
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t hello-python .'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
<<<<<<< HEAD
                sh 'kubectl apply -f deployment.yaml'
            }
        }
    }
=======
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
>>>>>>> 34e5553326f62fb9d55729c016c8729ae21b9df3
}
