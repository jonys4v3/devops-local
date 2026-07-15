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
=======
variable "network_name" {
  type = string
}

variable "gitlab_external_url" {
  type = string
}

variable "gitlab_ssh_port" {
  type = number
}
>>>>>>> f2191a0d70d4c15d9153b706889f519ab85c6a38
