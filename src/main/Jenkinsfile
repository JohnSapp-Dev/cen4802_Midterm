pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'Midterm_Pipeline_John_Sapp'
        DOCKER_REGISTRY = 'johnsappdev/midterm_pipeline_johnsapp'
    }

    stages {
        stage('Git pull') {
            steps {
                // pulls the code from the github repo
                git branch: 'main' url: 'https://github.com/JohnSapp-Dev/cen4802_Midterm'
            }
        }

        stage('Build program'){
            steps {
                // builds teh java program using maven
                sh './mvnw clean install'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                // builds the Docker image
                docker.build("${DOCKER_IMAGE}:${BUILD_NUMBER}")
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://hub.docker.com/repository/docker/johnsappdev/midterm_pipeline_johnsapp/general', 'docker-credentials') {
                        docker.image("${DOCKER_IMAGE}:${BUILD_NUMBER}").push()
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