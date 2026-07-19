variable "project_name" {
  description = "Nombre lógico del proyecto."
  type        = string
  default     = "devops-platform"
}

variable "environment" {
  description = "Entorno de despliegue."
  type        = string
  default     = "dev"
}

variable "docker_host" {
  description = "Docker host usado por Terraform."
  type        = string
  default     = "unix:///var/run/docker.sock"
}

variable "timezone" {
  description = "Zona horaria para los servicios."
  type        = string
  default     = "Atlantic/Canary"
}

variable "network_cidr" {
  description = "CIDR de red Docker."
  type        = string
  default     = "172.30.0.0/24"
}

variable "platform_admin_password" {
  description = "Password inicial común para GitLab root, Jenkins admin, Nexus admin y usuario administrador adicional."
  type        = string
  sensitive   = true
}

variable "platform_admin_user" {
  description = "Usuario administrador adicional que se creará en GitLab, Jenkins y Nexus."
  type        = string
  default     = "u01a538c"
}

variable "platform_admin_email" {
  description = "Email para el usuario administrador adicional."
  type        = string
  default     = "u01a538c@example.local"
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
  description = "Puerto HTTP host para Jenkins."
  type        = number
  default     = 8082
}

variable "jenkins_agent_port" {
  description = "Puerto agente Jenkins."
  type        = number
  default     = 50000
}

variable "nexus_http_port" {
  description = "Puerto HTTP host para Nexus."
  type        = number
  default     = 8081
}

variable "nexus_docker_group_port" {
  description = "Puerto reservado para repositorios Docker en Nexus."
  type        = number
  default     = 8083
}

variable "nexus_image" {
  description = "Imagen Docker de Nexus Repository 3."
  type        = string
  default     = "sonatype/nexus3:latest"
}

variable "nexus_java_min_mem" {
  type    = string
  default = "1200m"
}

variable "nexus_java_max_mem" {
  type    = string
  default = "1200m"
}

variable "nexus_java_direct_mem" {
  type    = string
  default = "2g"
}

variable "common_labels" {
  type    = map(string)
  default = {}
}
