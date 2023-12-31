# gets entire account info
data "aws_caller_identity" "current" {}

# prints out account id
output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

data "aws_eks_cluster" "existing_cluster" {
  name = "terraform-eks-dev"

}
output "eks_oidc_url" {
  description = "The OIDC provider URL for the EKS cluster"
  value       = data.aws_eks_cluster.existing_cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_policy" "external_dns" {
  name        = "external-dns-dev"
  description = "Policy using OIDC to give the EKS external dns ServiceAccount permissions to update Route53"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
  {
     "Effect": "Allow",
     "Action": [
       "route53:ChangeResourceRecordSets"
     ],
     "Resource": [
       "arn:aws:route53:::hostedzone/*"
     ]
   },
   {
     "Effect": "Allow",
     "Action": [
       "route53:ListHostedZones",
       "route53:ListResourceRecordSets"
     ],
     "Resource": [
       "*"
     ]
   }
  ]
}
EOF
}


resource "aws_iam_role" "external-dns-role" {
  name               = "external-dns-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(data.aws_eks_cluster.existing_cluster.identity[0].oidc[0].issuer, "https://", "")}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "${replace(data.aws_eks_cluster.existing_cluster.identity[0].oidc[0].issuer, "https://", "")}:sub": "system:serviceaccount:external-dns:external-dns"     
        }
      }
    }
  ]
}
EOF
}


resource "aws_iam_policy_attachment" "external-dns" {
  name       = "external-dns-attachment"
  roles      = [aws_iam_role.external-dns-role.name]
  policy_arn = aws_iam_policy.external_dns.arn
}


module "external-dns-terraform-k8s-namespace" {
  source = "../modules/namespaces/"
  name   = "external-dns"
}

module "external-dns-terraform-helm" {
  source               = "../modules/helm-charts/"
  deployment_name      = "external-dns"
  deployment_namespace = module.external-dns-terraform-k8s-namespace.namespace
  chart                = "external-dns"
  chart_version        = var.external-dns-config["chart_version"]
  repository           = "https://charts.bitnami.com/bitnami"
  values_yaml          = <<EOF
commonAnnotations: {
  cluster-autoscaler.kubernetes.io/safe-to-evict: "true"
}

aws:
  region: "${var.region}"
  zoneType: public
policy: sync
provider: aws
rbac:
  create: true 
serviceAccount:
  create: true
  name: "external-dns"
  annotations: 
    eks.amazonaws.com/role-arn: "${aws_iam_role.external-dns-role.arn}"
    
EOF
}