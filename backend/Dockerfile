# First stage: Build stage
FROM gradle:jdk-21-and-23-graal-jammy AS builder

# Set the working directory
WORKDIR /app

# Copy the Gradle Wrapper, its directory, and configuration files
COPY gradlew .
COPY gradle ./gradle
COPY build.gradle.kts .
COPY settings.gradle.kts .

# Grant execute permissions to the Gradle Wrapper script
RUN chmod +x ./gradlew

# Copy the source code for all modules
COPY back ./back
COPY front ./front

# Download dependencies
# Use ./gradlew instead of gradle to ensure the correct wrapper is used
RUN ./gradlew dependencies --no-daemon

# Build the application, excluding tests for speed
# Target the 'back' module specifically
RUN ./gradlew :back:build --no-daemon -x test

# Second stage: Runtime stage
FROM container-registry.oracle.com/graalvm/jdk:21

# Set the working directory
WORKDIR /app

# Copy the built JAR file and .env from the builder stage
COPY --from=builder /app/back/build/libs/*.jar app.jar
COPY --from=builder /app/.env .env

# Set the entry point to run the application
ENTRYPOINT ["java", "-Dspring.profiles.active=prod", "-jar", "app.jar"]