pipeline {
    agent any


    parameters {
        string(name: 'BRANCH', defaultValue: 'main', description: 'prueba')
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                   
                    // Realizar el checkout del servicio seleccionado y la rama
                    checkout([$class: 'GitSCM',
                        branches: [[name: params.BRANCH]],
                        doGenerateSubmoduleConfigurations: false,
                        extensions: [[$class: 'CloneOption', depth: 1, noTags: true, reference: '', shallow: true]],
                        submoduleCfg: [],
                        userRemoteConfigs: [[
                            url: 'URL_REPO.git',
                            credentialsId: 'Bitbucket-credentials'
                        ]]
                    ])
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }
        
        stage('Build Application') {
            steps {
                sh 'npm run build --prod'
            }
        }

        stage('Desplegar con Docker Compose') {
            steps {
                script {
                    // Ejecutar el Docker Compose dentro de la carpeta del servicio seleccionado
                    sh 'docker-compose down' // Asegurarse de detener contenedores existentes antes de crear nuevos
                    sh 'docker-compose up -d --build' // Construir y ejecutar los contenedores
                }
            }
        }
    }

    post {
        success {
            echo 'Despliegue completado con éxito'
        }
        failure {
            echo 'El despliegue falló'
        }
    }
}
