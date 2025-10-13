# Use a lightweight JDK base image
FROM eclipse-temurin:17-jdk
# Set workdir
WORKDIR /app
# Copy built jar
COPY target/springboot-demo-1.0.0.jar app.jar
# Expose port
EXPOSE 8080
# Run the app
ENTRYPOINT ["java", "-jar", "app.jar"]
