FROM gitlab/gitlab-ce:latest

LABEL org.opencontainers.image.title="GitLab CE personalizado para laboratorio DevOps"
LABEL org.opencontainers.image.description="Imagen GitLab CE gestionada desde Terraform con configuración Omnibus externa."
LABEL org.opencontainers.image.vendor="DevOps Lab"

HEALTHCHECK --interval=60s --timeout=10s --start-period=300s --retries=5   CMD /opt/gitlab/bin/gitlab-healthcheck --fail --max-time 10 || exit 1
