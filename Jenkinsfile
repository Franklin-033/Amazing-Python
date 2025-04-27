pipeline {
    agent any

  environment {
    scannerHome = tool 'SonarQubeScanner'  // Use the name you defined
    DOCKER_IMAGE = 'amazing-python-app-2023MCS320002' 
}

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Franklin-033/Amazing-Python.git'
            }
        }

        stage('Unit Test') {
            steps {
                sh 'python3 -m unittest discover Test'
            }
        }

    stage('SonarQube Analysis') {
          steps {
    withSonarQubeEnv('SonarQube') {
        sh '''
            ${scannerHome}/bin/sonar-scanner \
              -Dsonar.projectKey=amazing-python \
              -Dsonar.sources=. \
              -Dsonar.tests=Test \
              -Dsonar.test.inclusions=Test/*.py \
              -Dsonar.language=py \
              -Dsonar.sourceEncoding=UTF-8 \
              -Dsonar.host.url=$SONAR_HOST_URL \
              -Dsonar.login=$SONAR_AUTH_TOKEN
        '''
    }
        }
    }

          stage('Docker Build') {
            steps {
                sh '''
                    echo "Building Docker Image..."
                    docker build -t ${DOCKER_IMAGE} .
                '''
            }
        }

        stage('Docker Run') {
            steps {
                sh '''
                    echo "Running Docker Container..."
                    docker run -d --name amazing-python-container -p 5000:5000 ${DOCKER_IMAGE}
                '''
            }
        }
    }

    post {
        success {
            echo "Build and SonarQube Analysis completed successfully 🎯"
        }
        failure {
            echo "Something failed ❌. Check logs carefully."
        }
    }
}
