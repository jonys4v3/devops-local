variable "name" { type = string }
variable "cidr" { type = string }
variable "labels" {
  type    = map(string)
  default = {}
}
