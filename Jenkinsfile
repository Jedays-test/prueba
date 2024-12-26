pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Jedays-test/prueba.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                npm install
            }
        }

        stage('Lint') {
            steps {
                sh 'npm run lint' // Si aún necesitas usar sh para alguna tarea específica
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('your_sonar_server') {
                    sh 'sonarScanner'
                }
            }
        }
    }
}
