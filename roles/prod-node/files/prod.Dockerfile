# Use the official OpenJDK 17 runtime image
FROM eclipse-temurin:17-jdk

# Set working directory inside the container
WORKDIR /app

# Copy the Jenkins WAR file into the container
COPY jenkins*.war /app/jenkins.war

# Expose port 8080 for Jenkins
EXPOSE 8080

# Set the default command to run Jenkins
CMD ["java", "-jar", "/app/jenkins.war"]
