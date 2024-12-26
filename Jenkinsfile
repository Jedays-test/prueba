pipeline {
    agent any // Ejecutar en cualquier agente disponible

    stages {
        stage('Checkout') {
            steps {
                // Intenta usar un directorio de trabajo persistente para evitar clonados repetidos
                dir('workspace') {
                    // Si el directorio ya existe, realiza un fetch en lugar de un clone
                    sh '''
                        if [ -d ".git" ]; then
                            git fetch origin
                            git checkout origin/main // o la rama que corresponda
                        else
                            git clone https://github.com/Jedays-test/prueba.git .
                        fi
                    '''
                }
            }
        }

        stage('Build') {
            steps {
                dir('workspace') {
                    // Adapta esto a tu sistema de build (Gradle, Maven, npm, etc.)
                    // sh './gradlew clean build' // Ejemplo con Gradle
                    sh 'mvn clean install' // Ejemplo con Maven
                    // sh 'npm install' // Ejemplo con npm
                    // sh 'npm run build' // Ejemplo con npm para construir el proyecto
                }
            }
        }

        stage('Test') {
            steps {
                dir('workspace') {
                    // Ejecuta las pruebas unitarias
                    //sh './gradlew test' // Ejemplo con Gradle
                     sh 'mvn test' // Ejemplo con Maven
                    // sh 'npm test' // Ejemplo con npm
                }
            }
            post {
                // Recopila los resultados de las pruebas (JUnit XML) para visualizarlos en Jenkins
                always {
                    junit 'workspace/build/test-results/**/*.xml' // Ajusta la ruta si es necesario
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                dir('workspace') {
                    // Analiza el código con SonarQube (opcional)
                    withSonarQubeEnv('SonarQube Server') { // 'SonarQube Server' es el nombre configurado en Jenkins
                        sh './gradlew sonarqube' // Ejemplo con Gradle
                        // sh 'mvn sonar:sonar' // Ejemplo con Maven
                    }
                }
            }
        }

        stage('Package') {
            steps {
                dir('workspace') {
                  // Empaqueta la aplicación para su distribución (ejemplo: crear un JAR o WAR)
                  sh './gradlew assemble' // Ejemplo con Gradle
                }
            }
        }

        stage('Publish Artifacts') {
          steps {
            archiveArtifacts artifacts: 'workspace/build/libs/*.jar', allowEmptyArchive: true
          }
        }
    }
}
