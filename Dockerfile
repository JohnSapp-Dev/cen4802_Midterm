FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy Maven wrapper and project files
COPY mvnw ./
COPY .mvn .mvn
COPY pom.xml ./

# Ensure mvnw is executable
RUN chmod +x mvnw

# Diagnostic step to ensure mvnw is present
RUN ls -al /app

# Run Maven dependencies offline and build the project
#RUN ./mvnw dependency:go-offline
RUN ./mvnw clean install -DskipTests

# Copy the source code
COPY src ./src

# Set the default command to run the app
CMD ["java", "-jar", "/app/target/simple-calculator2-1.0.0.jar"]
