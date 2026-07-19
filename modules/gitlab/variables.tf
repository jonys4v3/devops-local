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

variable "external_url" {
  type = string
}

variable "http_port" {
  type = number
}

variable "ssh_port" {
  type = number
}

variable "labels" {
  type    = map(string)
  default = {}
}