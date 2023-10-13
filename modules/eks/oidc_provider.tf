data "aws_iam_policy_document" "dev_oidc_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:default:aws-test"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "dev_oidc" {
  assume_role_policy = data.aws_iam_policy_document.dev_oidc_assume_role_policy.json
  name               = "${var.cluster-name}-oidc"
}

resource "aws_iam_policy" "dev-policy" {
  name = "${var.cluster-name}-policy"

  policy = jsonencode({
    Statement = [{
      Action = [
        "s3:ListAllMyBuckets",
        "s3:GetBucketLocation"
      ]
      Effect   = "Allow"
      Resource = "arn:aws:s3:::*"
    }]
    Version = "2012-10-17"
  })
}


resource "aws_iam_role_policy_attachment" "dev_attach" {
  role       = aws_iam_role.dev_oidc.name
  policy_arn = aws_iam_policy.dev-policy.arn
}

data "tls_certificate" "eks" {
  url = aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}


# The purpose of creating an IAM OIDC identity provider is to enable IAM roles to trust an OIDC identity provider,
# such as the one provided by an EKS cluster. With this trust relationship established, 
# you can then create IAM roles that can be assumed by entities (like Kubernetes service accounts) 
# authenticated by that OIDC provider.
# This setup is commonly used to give Kubernetes service accounts specific AWS permissions. 
# When a pod runs with a specific service account in EKS, it can assume an AWS IAM role and get the
# permissions attached to that role, enabling AWS resource access directly from the pod.


resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

