variable "path_to_public_key" {
  default = "/home/ec2-user/.ssh/id_rsa.pub"
}


variable "cluster-name" {
  default = "terraform-eks-dev"
  type    = string
}


variable "region" {
  default = "us-east-1"
  type    = string
}