# Use the official Tomcat image
FROM tomcat:9.0.97-jdk17

# Remove the default web applications from Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the war file generated from the build node
COPY joinfaces-example.war /usr/local/tomcat/webapps/

# Expose port 8080 for access to joinfaces-example
EXPOSE 8080

# Run Tomcat
CMD ["catalina.sh", "run"]
