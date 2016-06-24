FROM ctarwater/armhf-alpine-rpi-java8
MAINTAINER chrisanthropic <ctarwater@gmail.com>

# docker run -d -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock -v /home/jenkins:/var/jenkins_home ctarwater/armhf-alpine-rpi-jenkins

# ENV VARS
ENV JENKINS_VERSION 2.10

RUN echo "http://dl-6.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk upgrade --update && \
    apk add --update \
    gnupg \
    tar \
    ruby \
    git \
    zip \
    curl \
    wget \
    sudo \
    docker \
    && rm -rf /var/cache/apk/*

# Add jenkins user
RUN addgroup jenkins && \
    adduser -h /var/jenkins_home -D -s /bin/bash -G jenkins jenkins

# Setup
RUN mkdir -p /usr/share/jenkins && \
    chown -R jenkins:jenkins /usr/share/jenkins && \
    chmod -R 775 /usr/share/jenkins

# Let the jenkins user run with passwordless sudo
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers
    
# Start docker at boot
RUN rc-update add docker boot
    
USER jenkins

# Live dangerously - use unstable Jenkins
RUN curl -fL http://mirrors.jenkins-ci.org/war/$JENKINS_VERSION/jenkins.war -o /usr/share/jenkins/jenkins.war

WORKDIR /var/jenkins_home

# Volumes
ENV JENKINS_HOME /var/jenkins_home

# for main web interface:
EXPOSE 8080


CMD ["java",  "-jar",  "/usr/share/jenkins/jenkins.war"]
