pipeline {
    agent any
    environment {
        SWARM_SERVICE_NAME = 'service_initiator'
    }
    stages {
        stage('Building') {
            steps {
                sh """
                docker build -t ${env.SWARM_SERVICE_NAME}:${env.GIT_COMMIT} .
                """
            }
        }  

        stage('Updating Serices') {
            steps {
                sh """docker run --rm ${env.SWARM_SERVICE_NAME}:${env.GIT_COMMIT}"""
            }
        }    
    }
}