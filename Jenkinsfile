
pipeline {    
    agent any
    stages {
        stage ('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                '''
            }
        }
		stage ('SonarQube') {
            steps {
				echo "SonarQube analysis"
            }
        }

        stage ('Build') {
            steps {
                sh 'mvn package -DskipTests=true' 
            }
        }

        stage ('Delivery') {
            steps {
				sh "scp target/*.jar $APP_USER@$APP_HOST:$APP_HOME/${artifactId}.jar"
            }
        }

        stage ('Deploy') {
            steps {
                ansiblePlaybook colorized: true, 
                	installation: 'ansible', 
            		inventory: '$ANSIBLE_HOME/inventories/dev.ini', 
            		playbook: '$ANSIBLE_HOME/main.yml', 
            		extras: '-e group_id=$groupId -e artifact_id=$artifactId -e artifact_version=$version'
            }
        }
        
    }
    
    post {
        always {
            archiveArtifacts artifacts: 'target/*.jar', fingerprint: true
           	junit 'target/surefire-reports/*.xml'
        }
    }

}
