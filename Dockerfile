# Stage 1: Build the project with Maven
FROM maven:3.8.6-openjdk-17-slim AS builder

WORKDIR /app

# Copy the Maven wrapper and project files
COPY mvnw ./
COPY .mvn .mvn
COPY pom.xml ./

# Ensure mvnw is executable
RUN chmod +x mvnw

# Run Maven dependencies offline (optional)
RUN ./mvnw dependency:go-offline

# Copy the source code
COPY src ./src

# Build the project (skip tests)
RUN ./mvnw clean install -DskipTests

# Stage 2: Run the application using a smaller base image
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy the built JAR file from the builder stage
COPY --from=builder /app/target/*.jar /app/app.jar

# Set the default command to run the app
CMD ["java", "-jar", "/app/app.jar"]
