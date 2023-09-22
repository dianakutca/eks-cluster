variable "vpc_name" {
  default = "Vpc"
}

variable "region" {
  description = "please provide a region information"
  type        = string
  default     = ""
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