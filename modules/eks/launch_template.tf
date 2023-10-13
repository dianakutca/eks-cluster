# locals {
#   mime_boundary   = "==MIMEBOUNDARY=="
#   eks_endpoint    = aws_eks_cluster.cluster.endpoint
#   eks_certificate = aws_eks_cluster.cluster.certificate_authority[0].data
#   cluster_name    = var.cluster-name

#   mime_userdata = <<EOD
# MIME-Version: 1.0
# Content-Type: multipart/mixed; boundary="${local.mime_boundary}"

# --${local.mime_boundary}
# Content-Type: text/x-shellscript; charset="us-ascii"

# #!/bin/bash
# /etc/eks/bootstrap.sh --apiserver-endpoint '${local.eks_endpoint}' --b64-cluster-ca '${local.eks_certificate}' '${local.cluster_name}'

# --${local.mime_boundary}--
# EOD
# }


resource "aws_launch_template" "eks-launch-template" {
  name_prefix = "eks-launch-template-"
  key_name    = aws_key_pair.eks-key.key_name
  # user_data   = base64encode(local.mime_userdata)


  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 20
    }
  }
  # instance_type = "t2.medium"


  # Add security group IDs here
  vpc_security_group_ids = [aws_security_group.eks_worker_sg.id]

}