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
                    sh 'sonar-scanner'
                }
            }
        }

    }
}
