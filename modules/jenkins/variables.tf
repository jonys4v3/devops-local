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
  type = string
}

variable "timezone" {
  type = string
}

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