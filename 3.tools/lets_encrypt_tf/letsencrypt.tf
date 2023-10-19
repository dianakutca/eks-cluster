resource "kubernetes_manifest" "lets_encrypt_clusterissuer" {
  manifest = yamldecode(file("${path.module}/../lets-encrypt-stage/cluster_issuer.yaml"))
}

resource "kubernetes_manifest" "lets_encrypt_certificate" {
  manifest = yamldecode(file("${path.module}/../lets-encrypt-stage/certificate.yaml"))
}