pipeline {
    agent any

    environment {
        SONARQUBE_SERVER = 'SonarQube'
        
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Franklin-033/Amazing-Python.git'
            }
        }

        stage('Install & Test') {
            steps {
                sh 'python3 -m unittest discover Test'
            }
        }

        stage('SonarQube Analysis') {
            steps {
        withSonarQubeEnv("${SONARQUBE_SERVER}") {
            sh '''
                # Download sonar-scanner if not present
                if ! [ -x "$(command -v sonar-scanner)" ]; then
                  apt-get update && apt-get install -y unzip wget
                  wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-5.0.1.3006-linux.zip
                  unzip sonar-scanner-cli-5.0.1.3006-linux.zip
                  export PATH=$PATH:$(pwd)/sonar-scanner-5.0.1.3006-linux/bin
                fi

                sonar-scanner
            '''
        }

    }
}
    }

}
