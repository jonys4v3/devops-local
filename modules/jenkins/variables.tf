variable "project_name" {
  type = string
}

variable "timezone" {
  type = string
}

variable "network_name" {
  type = string
}

variable "jenkins_version" {
  type = string
}

variable "jenkins_admin_user" {
  type = string
}

variable "jenkins_admin_password" {
  type      = string
  sensitive = true
}

variable "jenkins_public_url" {
  type = string
}

variable "jenkins_admin_email" {
  type = string
}
