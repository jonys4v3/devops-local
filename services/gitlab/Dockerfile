FROM gitlab/gitlab-ce:latest

<<<<<<< HEAD
COPY config/gitlab_omnibus_config.tpl /opt/gitlab/templates/gitlab_omnibus_config.tpl
=======
LABEL org.opencontainers.image.title="GitLab CE personalizado para laboratorio DevOps"
LABEL org.opencontainers.image.description="Imagen GitLab CE gestionada desde Terraform con configuración Omnibus externa."
LABEL org.opencontainers.image.vendor="DevOps Lab"

HEALTHCHECK --interval=60s --timeout=10s --start-period=300s --retries=5   CMD /opt/gitlab/bin/gitlab-healthcheck --fail --max-time 10 || exit 1
>>>>>>> f2191a0d70d4c15d9153b706889f519ab85c6a38
