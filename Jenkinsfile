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
                echo 'Running SonarQube Scan'
                withCredentials([string(credentialsId: 'Sonar-token', variable: 'SONAR_TOKEN')]) {
                    sh '''
                        # Install sonar-scanner if not installed
                        if ! command -v sonar-scanner &> /dev/null
                        then
                            echo "Installing sonar-scanner..."
                            wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.9.0.43723-linux.zip
                            unzip sonar-scanner-cli-4.9.0.43723-linux.zip
                            export PATH=$PWD/sonar-scanner-4.9.0.43723-linux/bin:$PATH
                        fi

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
                withCredentials([file(credentialsId: 'kubeconfig-dev', variable: 'KUBECONFIG_FILE')]) {
                    sh '''
                        mkdir -p .kube
                        cp $KUBECONFIG_FILE .kube/config
                        
                        docker run --rm \
                          -v $(pwd)/.kube/config:/.kube/config \
                          -v $(pwd):/workspace \
                          -w /workspace \
                          bitnami/kubectl:latest \
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
