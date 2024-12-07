FROM ubuntu:20.04

ARG JENKINS_TAG=master

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies and clean up after installation
RUN apt-get update && apt-get install -y \
    apt-utils \
    openjdk-17-jdk \
    wget \
    tar \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Install Maven 4.0.0-rc-1
RUN wget https://downloads.apache.org/maven/maven-4/4.0.0-rc-1/binaries/apache-maven-4.0.0-rc-1-bin.tar.gz && \
    tar -xzf apache-maven-4.0.0-rc-1-bin.tar.gz && \
    mv apache-maven-4.0.0-rc-1 /opt/maven && \
    rm apache-maven-4.0.0-rc-1-bin.tar.gz && \
    ln -s /opt/maven/bin/mvn /usr/bin/mvn

# Add sources and set up working directory
COPY . /opt/build
WORKDIR /opt/build/src

# Build and move the war file
RUN mkdir -p /war-files && \
    mvn clean package -DskipTests -T 2C && \
    if [ -f target/jenkins.war ]; then \
      mv target/jenkins.war /war-files/jenkins.war; \
    fi
