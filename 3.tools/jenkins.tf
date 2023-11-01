module "jenkins-namespace" {
  source = "../modules/namespaces/"
  name   = "jenkins"
}

module "jenkins-terraform-helm" {
  source               = "../modules/helm-charts/"
  deployment_name      = "jenkins"
  deployment_namespace = module.jenkins-namespace.namespace
  chart                = "jenkins"
  chart_version        = var.jenkins-config["chart_version"]
  repository           = "https://charts.jenkins.io"
  values_yaml          = <<EOF
controller: 
  adminUser: "${var.username}"
  adminPassword: "${var.password}"
  installLatestPlugins: true
  ingressClassName: nginx
  ingress:
    enabled: true
    annotations:
      kubernetes.io/ingress.class: nginx
      cert-manager.io/cluster-issuer: letsencrypt-prod
      acme.cert-manager.io/http01-edit-in-place: "true"
      ingress.kubernetes.io/ssl-redirect: "true"
    hosts: 
      - host: "jenkins.${var.domain_name}"
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: jenkins
                port:
                  number: 8080
    tls: 
      - secretName: jenkins-server-tls
        hosts:
          - "jenkins.${var.domain_name}"

EOF
}

      # external-dns.alpha.kubernetes.io/hostname: jenkins.${var.domain_name}
