variable "project_name" {
  description = "Nombre base del laboratorio DevOps. Se usa como prefijo de recursos Docker."
  type        = string
  default     = "devops"
}

variable "docker_host" {
  description = "Socket Docker local. En Linux/WSL suele ser unix:///var/run/docker.sock."
  type        = string
  default     = "unix:///var/run/docker.sock"
}

variable "timezone" {
  description = "Zona horaria de los contenedores."
  type        = string
  default     = "Atlantic/Canary"
}

variable "gitlab_external_url" {
  description = "URL externa/local de GitLab."
  type        = string
  default     = "http://gitlab:8929"
}

variable "gitlab_ssh_port" {
  description = "Puerto SSH expuesto para GitLab."
  type        = number
  default     = 2222
}

variable "jenkins_version" {
  description = "Versión Jenkins LTS usada por el Dockerfile de Jenkins."
  type        = string
  default     = "2.568.1"
}

variable "jenkins_admin_user" {
  description = "Usuario administrador inicial de Jenkins."
  type        = string
  default     = "admin"
}

variable "jenkins_admin_password" {
  description = "Contraseña inicial de Jenkins. Cambiar en terraform.tfvars."
  type        = string
  sensitive   = true
  default     = "CambiarEstaPassword123!"
}

variable "jenkins_public_url" {
  description = "URL local/pública de Jenkins."
  type        = string
  default     = "http://jenkins:8080/"
}

variable "jenkins_admin_email" {
  description = "Correo de administración de Jenkins."
  type        = string
  default     = "admin@example.com"
}

variable "artifactory_public_url" {
  description = "URL local/pública de Artifactory."
  type        = string
  default     = "http://artifactory:8082/"
}

variable "artifactory_db_name" {
  description = "Nombre de la base de datos PostgreSQL para Artifactory."
  type        = string
  default     = "artifactory"
}

variable "artifactory_db_user" {
  description = "Usuario PostgreSQL para Artifactory."
  type        = string
  default     = "artifactory"
}

variable "artifactory_db_password" {
  description = "Password PostgreSQL para Artifactory."
  type        = string
  sensitive   = true
  default     = "ArtifactoryPostgres123!"
}
