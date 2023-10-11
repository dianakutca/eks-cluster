### External cli kubergrunt
data "external" "thumb" {
  program = ["kubergrunt", "eks", "oidc-thumbprint", "--issuer-url", "${aws_eks_cluster.cluster.identity.0.oidc.0.issuer}"]
}

### OIDC config
resource "aws_iam_openid_connect_provider" "cluster" {
  depends_on      = [data.external.thumb]
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.external.thumb.result["thumbprint"]]
  url             = aws_eks_cluster.cluster.identity.0.oidc.0.issuer
}
