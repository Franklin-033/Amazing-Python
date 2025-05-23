pipeline {
    agent any

  environment {
    scannerHome = tool 'SonarQubeScanner'  // Use the name you defined
    
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
                    docker build -t amazing-python-app:latest .
                '''
            }
        }

        stage('Docker Run') {
            steps {
                sh '''
                    echo "Running Docker Container..."
                    docker run --name amazing-python-app -p 5000:5000 amazing-python-app
                '''
            }
        }

        stage('Docker Push') {
        steps {
           withCredentials([usernamePassword(credentialsId: 'jenkins-doccker', usernameVariable: 'DOCKERHUB_USER', passwordVariable: 'DOCKERHUB_PASS')]) {
          sh '''
                echo "$DOCKERHUB_PASS" | docker login -u "$DOCKERHUB_USER" --password-stdin
                docker tag amazing-python-app:latest prasadm033/amazing-python-app:latest
                docker push $DOCKERHUB_USER/amazing-python-app:latest
            '''
         }
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
