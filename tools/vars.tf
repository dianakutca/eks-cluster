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
    chart_version   = "6.18.0"
  }
}

variable "domain_name" {
    type = string
    default = ""
}