variable "path_to_public_key" {
  default = ""
  type    = string
}


variable "cluster-name" {
  default = ""
  type    = string
}


variable "region" {
  default = ""
  type    = string
}

variable "vpc_id" {
  type    = list(string)
}

variable "subnet_ids" {
  type    = list(string)
}
