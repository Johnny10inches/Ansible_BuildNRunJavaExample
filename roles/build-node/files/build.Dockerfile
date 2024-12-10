# Use the official Maven image with JDK 17
FROM maven:3.9.9-eclipse-temurin-17

# Set the working directory inside the container
WORKDIR /app

# Copy the project into the container
COPY . .

# Build the project and move the WAR file to /war-files
RUN mkdir -p /war-files && \
    mvn clean package -DskipTests -T 2C

# Define the default command to copy artifacts from the container
CMD ["sh", "-c", "cp -r app/target/jenkins.war /artifacts"]
