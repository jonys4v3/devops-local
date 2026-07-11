FROM releases-docker.jfrog.io/jfrog/artifactory-oss:latest

LABEL org.opencontainers.image.title="Artifactory OSS personalizado para laboratorio DevOps"
LABEL org.opencontainers.image.description="Artifactory OSS con configuración base y preparado para despliegue con Terraform."
LABEL org.opencontainers.image.vendor="DevOps Lab"

USER root

RUN mkdir -p /opt/jfrog/artifactory/var/etc \
    && chown -R 1030:1030 /opt/jfrog/artifactory/var/etc

COPY config/system.yaml /opt/jfrog/artifactory/var/etc/system.yaml

RUN chown 1030:1030 /opt/jfrog/artifactory/var/etc/system.yaml

USER 1030