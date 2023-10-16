variable "region" {
  description = "Please provide a region"
  type        = string
  default     = ""
}

variable "external-dns-config" {
  type        = map(any)
  description = "Please define external-dns configurations"
  default = {
    deployment_name = "external-dns"
    chart_version   = "6.26.4"
  }
}

variable "domain_name" {
  type    = string
  default = ""
}

variable "bucket" {
  default = ""
  type = string
}

variable "dynamodb_table" {
  default = ""
  type = string
}