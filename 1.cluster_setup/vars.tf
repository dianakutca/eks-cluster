variable "aws_account" {
  default = ""
  type    = string
}

variable "bucket" {
  default = ""
  type = string
}

variable "dynamodb_table" {
  default = ""
  type = string
}

variable "region" {
  default = ""
  type = string
}

variable "path_to_public_key" {
  default = ""
  type = string
}

variable "cluster-name" {
  default = ""
  type = string
}

variable "vpc_name" {
  default = ""
}

variable "cidr_block" {
  description = "please provide a cidr_block information"
  type        = string
  default     = ""
}


variable "public_subnet1" {
  description = "cidr-block for public subnet"
  type        = string
  default     = ""
}

variable "public_subnet2" {
  description = "cidr-block for public subnet"
  type        = string
  default     = ""
}

variable "public_subnet3" {
  description = "cidr-block for public subnet"
  type        = string
  default     = ""
}

variable "private_subnet1" {
  description = "cidr-block for private subnet"
  type        = string
  default     = ""
}

variable "private_subnet2" {
  description = "cidr-block for private subnet"
  type        = string
  default     = ""
}

variable "private_subnet3" {
  description = "cidr-block for private subnet"
  type        = string
  default     = ""
}