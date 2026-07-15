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
