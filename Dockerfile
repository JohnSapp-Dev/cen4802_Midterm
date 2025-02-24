FROM openjdk:17-jdk-slim
WORKDIR /app
COPY mvnw ./
COPY .mvn .mvn
COPY pom.xml ./
RUN chmod +x mvnw && ./mvnw dependency:go-offline
COPY src ./src
RUN ./mvnw clean install -DskipTests
CMD ["java", "-jar", "/app/target/simple-calculator2-1.0.0.jar"]