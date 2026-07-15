<<<<<<< HEAD
variable "name" {
  description = "Nombre de la red Docker."
  type        = string
}

variable "cidr" {
  description = "CIDR de la red Docker."
  type        = string
}

variable "labels" {
  description = "Labels comunes."
  type        = map(string)
  default     = {}
=======
variable "project_name" {
  type = string
>>>>>>> f2191a0d70d4c15d9153b706889f519ab85c6a38
}
