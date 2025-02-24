pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'midterm_pipeline_john_sapp'
        DOCKER_REGISTRY = 'johnsappdev/midterm_pipeline_johnsapp'
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

        stage('Create Dockerfile') {
            steps {
                script {
                    // Get the path to the generated JAR file
                    //def jarFile = sh(script: "ls target/*.jar", returnStdout: true).trim()
                    //env.JAR_FILE_PATH = jarFile
                    //echo "JAR file: ${env.JAR_FILE_PATH}"

                    // Make sure mvnw is executable in Jenkins
                    sh 'chmod +x mvnw'

                    // Dynamically create the Dockerfile for building the image
                    writeFile file: 'Dockerfile', text: """
                    FROM openjdk:17-jdk-slim
                    WORKDIR /app
                    COPY mvnw ./
                    COPY .mvn .mvn
                    COPY pom.xml ./
                    RUN chmod +x mvnw
                    COPY src ./src
                    RUN ./mvnw clean install -DskipTests
                    CMD ["java", "-jar", "/app/target/simple-calculator2-1.0.0.jar"]
                    """
                }
            }
        }


        stage('Build Docker Image') {
            steps {
                script {
                // builds the Docker image
                docker.build("${DOCKER_IMAGE}")
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