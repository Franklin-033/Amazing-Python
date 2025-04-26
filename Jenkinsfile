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
