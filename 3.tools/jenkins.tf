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
    jenkinsUrlProtocol: "https"
    apiVersion: "networking.k8s.io/v1" 
    annotations:
      kubernetes.io/ingress.class: nginx
      cert-manager.io/cluster-issuer: letsencrypt-prod
      acme.cert-manager.io/http01-edit-in-place: "true"
      ingress.kubernetes.io/ssl-redirect: "true"
    hostName: "jenkins-test.${var.domain_name}"
    paths: # Define the paths for Ingress
      - path: / # Default path to match all traffic
        pathType: Prefix # Prefix is the most common pathType
        backend:
          service:
            name: jenkins # Name of your Jenkins service
            port:
              number: 8080 # The port on which Jenkins is running
    tls: 
      - secretName: jenkins-server-tls-test
        hosts:
          - "jenkins-test.${var.domain_name}"
EOF
}

      # external-dns.alpha.kubernetes.io/hostname: jenkins.${var.domain_name}

    # hosts: 
    #   - host: "jenkins-test.${var.domain_name}"
    #     paths:
    #       - path: /
    #         pathType: Prefix
    # tls: 
    #   - secretName: jenkins-server-tls-test
    #     hosts:
    #       - "jenkins-test.${var.domain_name}"
