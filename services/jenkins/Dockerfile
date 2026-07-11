FROM jenkins/jenkins:2.568.1-jdk21

LABEL org.opencontainers.image.title="Jenkins LTS seguro para laboratorio DevOps"
LABEL org.opencontainers.image.description="Jenkins LTS con Java 21, plugins preinstalados y configuración JCasC."
LABEL org.opencontainers.image.vendor="DevOps Lab"

USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       docker.io \
       curl \
       git \
       openssh-client \
       ca-certificates \
       tzdata \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER jenkins

COPY config/plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY config/init.groovy.d/ /usr/share/jenkins/ref/init.groovy.d/

RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt