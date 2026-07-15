<<<<<<< HEAD
FROM jenkins/jenkins:lts-jdk17

USER root
RUN apt-get update \
    && apt-get install -y --no-install-recommends docker.io curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

USER jenkins
COPY config/plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

COPY config/casc.yaml /usr/share/jenkins/ref/casc.yaml
ENV CASC_JENKINS_CONFIG=/usr/share/jenkins/ref/casc.yaml
=======
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
>>>>>>> f2191a0d70d4c15d9153b706889f519ab85c6a38
