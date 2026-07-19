variable "name" { type = string }
variable "image" { type = string }
variable "network_name" { type = string }
variable "timezone" { type = string }
variable "http_port" { type = number }
variable "docker_group_port" { type = number }
variable "java_min_mem" { type = string }
variable "java_max_mem" { type = string }
variable "java_direct_mem" { type = string }
variable "admin_password" {
  type      = string
  sensitive = true
}
variable "extra_admin_user" { type = string }
variable "extra_admin_email" { type = string }
variable "extra_admin_password" {
  type      = string
  sensitive = true
}
variable "labels" {
  type    = map(string)
  default = {}
}
