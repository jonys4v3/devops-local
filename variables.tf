variable "project_name" {
  description = "Nombre lógico del proyecto. Se usa como prefijo de recursos."
  type        = string
  default     = "devops-platform"
}

variable "environment" {
  description = "Entorno de despliegue. Ejemplo: dev, staging o prod."
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment debe ser dev, staging o prod."
  }
}

variable "docker_host" {
  description = "Docker host usado por el provider. En Linux normalmente unix:///var/run/docker.sock."
  type        = string
  default     = "unix:///var/run/docker.sock"
}

variable "timezone" {
  description = "Zona horaria para los servicios."
  type        = string
  default     = "Atlantic/Canary"
}

variable "network_cidr" {
  description = "CIDR de la red Docker bridge."
  type        = string
  default     = "172.30.0.0/24"
}

variable "gitlab_external_url" {
  description = "URL externa de GitLab."
  type        = string
  default     = "http://localhost:8080"
}

variable "gitlab_http_port" {
  description = "Puerto HTTP del host para GitLab."
  type        = number
  default     = 8080
}

variable "gitlab_ssh_port" {
  description = "Puerto SSH del host para GitLab."
  type        = number
  default     = 2222
}

variable "jenkins_http_port" {
  description = "Puerto HTTP del host para Jenkins."
  type        = number
  default     = 8082
}

variable "jenkins_agent_port" {
  description = "Puerto del agente Jenkins."
  type        = number
  default     = 50000
}

variable "jenkins_admin_user" {
  description = "Usuario administrador inicial de Jenkins."
  type        = string
  default     = "admin"
}

variable "jenkins_admin_password" {
  description = "Password administrador inicial de Jenkins. No lo guardes en Git. Usa TF_VAR_jenkins_admin_password."
  type        = string
  sensitive   = true
  default     = null
}

variable "nexus_http_port" {
  description = "Puerto HTTP del host para Nexus Repository."
  type        = number
  default     = 8081
}

variable "nexus_docker_group_port" {
  description = "Puerto opcional para registry Docker group en Nexus, si lo configuras en la UI/API."
  type        = number
  default     = 8083
}

variable "nexus_image" {
  description = "Imagen Docker de Nexus Repository 3."
  type        = string
  default     = "sonatype/nexus3:latest"
}

variable "nexus_java_min_mem" {
  description = "Memoria mínima de JVM para Nexus."
  type        = string
  default     = "1200m"
}

variable "nexus_java_max_mem" {
  description = "Memoria máxima de JVM para Nexus."
  type        = string
  default     = "1200m"
}

variable "nexus_java_direct_mem" {
  description = "Memoria directa máxima de JVM para Nexus."
  type        = string
  default     = "2g"
}

variable "common_labels" {
  description = "Labels comunes aplicadas a contenedores, redes y volúmenes."
  type        = map(string)
  default     = {}
}
