pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Jedays-test/prueba.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t mi-imagen:latest .'
            }
        }

        stage('Run Tests in Docker Container') {
            steps {
                sh 'docker run -it mi-imagen:latest npm test'
            }
        }
    }
}
