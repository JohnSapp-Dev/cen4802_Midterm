pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'midterm_pipeline_john_sapp'
        DOCKER_REGISTRY = 'johnsappdev/midterm_pipeline_johnsapp'
    }
    tools {
        maven "3.9.9"
    }
    stages {
        stage('Git pull') {
            steps {
                // pulls the code from the github repo
                git branch: 'master', url: 'https://github.com/JohnSapp-Dev/cen4802_Midterm'
            }
        }
        stage('Build program'){
            steps {
                // Make mvnw executable
                sh 'chmod +x mvnw'
                // builds the java program using maven
                sh './mvnw clean install'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                // builds the Docker image
                docker.build("${DOCKER_IMAGE}",".")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://hub.docker.com/repository/docker/johnsappdev/midterm_pipeline_johnsapp/general', 'docker-credentials') {
                        docker.image("${DOCKER_IMAGE}").push()
                        }
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}