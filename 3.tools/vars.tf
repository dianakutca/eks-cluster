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

variable "cert-manager-config" {
  type        = map(any)
  description = "Please define cert-manager configurations"
  default = {
    deployment_name = "cert-manager"
    chart_version   = "1.13.1"
  }
} 

variable "domain_name" {
  type    = string
  default = ""
}

variable "email" {
  type    = string
  default = ""
}

variable "jenkins-config" {
  type        = map(any)
  description = "Please define jenkins configurations"
  default = {
    deployment_name = "jenkins"
    chart_version   = "4.7.2"
  }
}
variable "username" {
  description = "Please provide a region"
  type        = string
  default     = ""

}

variable "password" {
  description = "Please provide a region"
  type        = string
  sensitive   = true 
}

#https://github.com/kubernetes/ingress-nginx/blob/main/charts/ingress-nginx/README.md#migrating-from-stablenginx-ingress
variable "ingress-controller-config" {
  type        = map(any)
  description = "Please define ingress configurations"
  default = {
    deployment_name          = "ingress-controller"
    chart_version            = "4.8.2"
    loadBalancerSourceRanges = " 24.14.156.131"
  }
}

# This block is used to setup grafana
variable "grafana-config" {
  type = map(any)
  default = {
    deployment_name = "grafana"
    chart_version   = "6.43.3"
    adminPassword   = "password"
    adminUser       = "admin"
  }
}

# This block is used to setup prometheus
variable "prometheus-config" {
  type        = map(any)
  description = "Please define prometheus configurations"
  default = {
    deployment_name = "prometheus"
    chart_version   = "15.17.0"
  }
}