<<<<<<< HEAD
variable "name" {
  type = string
}

variable "image_name" {
  type = string
}

variable "build_context" {
  type = string
}

variable "network_name" {
=======
variable "project_name" {
>>>>>>> f2191a0d70d4c15d9153b706889f519ab85c6a38
  type = string
}

variable "timezone" {
  type = string
}

<<<<<<< HEAD
variable "http_port" {
  type = number
}

variable "agent_port" {
  type = number
}

variable "admin_user" {
  type = string
}

variable "admin_password" {
  type      = string
  sensitive = true
  default   = null
}

variable "labels" {
  type    = map(string)
  default = {}
}
=======
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
>>>>>>> f2191a0d70d4c15d9153b706889f519ab85c6a38
