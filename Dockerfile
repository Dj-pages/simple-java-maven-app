# Multi-stage build for efficient image size

# Stage 1: Build the application
FROM maven:3.9.9-eclipse-temurin-11 AS build

# Set working directory
WORKDIR /app

# Copy pom.xml and download dependencies (for better caching)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source code
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Stage 2: Create runtime image
FROM eclipse-temurin:11-jre-alpine

# Set working directory
WORKDIR /app

# Copy the JAR file from build stage
COPY --from=build /app/target/*.jar app.jar

# Expose port (if your app uses a specific port, change this)
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]

# Optional: Add healthcheck
HEALTHCHECK --interval=30s --timeout=3s \
  CMD ps aux | grep 'java -jar app.jar' || exit 1