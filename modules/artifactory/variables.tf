variable "project_name" {
  type = string
}

variable "timezone" {
  type = string
}

variable "network_name" {
  type = string
}

variable "artifactory_public_url" {
  type = string
}

variable "artifactory_db_name" {
  type = string
}

variable "artifactory_db_user" {
  type = string
}

variable "artifactory_db_password" {
  type      = string
  sensitive = true
}