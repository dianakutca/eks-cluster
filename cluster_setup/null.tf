data "terraform_remote_state" "eks_output" {
  backend = "s3" # Use the appropriate backend configuration
  config = {
    bucket = "terraform-project-dianakutca-eks-setup"
    key    = "dev/home/ec2-user/eks-cluster/terraform.tfstate"
    region = "us-east-1" # Replace with the correct region
  }
}

resource "null_resource" "generate_config_map" {
  count      = 1
  depends_on = [module.eks]
  triggers = {
    node_role_arn = data.terraform_remote_state.eks_output.outputs.worker_node_role_arn
    cluster_name  = module.eks.cluster_name
  }

  provisioner "local-exec" {
    command = <<-EOT
      cat <<EOF > config-map-aws-auth.yaml
      apiVersion: v1
      kind: ConfigMap
      metadata:
        name: aws-auth
        namespace: kube-system
      data:
        mapRoles: |
          - rolearn: ${data.terraform_remote_state.eks_output.outputs.worker_node_role_arn}
            username: system:node:{{EC2PrivateDNSName}}
            groups:
              - system:bootstrappers
              - system:nodes
        mapUsers: |
          - userarn: arn:aws:iam::${var.aws_account}:root
            groups:
              - system:masters
      EOF
    EOT
  }
}


