# Use the official Maven image with JDK 17
FROM maven:3.9.4-eclipse-temurin-17

# Set the working directory inside the container
WORKDIR /app

# Copy the project into the container
COPY . .

# Build the project and move the WAR file to /war-files
RUN mkdir -p /war-files && \
    mvn clean package -DskipTests -T 2C && \
    if [ -f target/joinfaces-example.war ]; then \
      mv target/joinfaces-example-5.4.x.war /war-files/joinfaces-example-5.4.x.war; \
    fi

# Define the default command to copy artifacts from the container
CMD ["sh", "-c", "cp -r /war-files/joinfaces-example-5.4.x.war /artifacts"]
