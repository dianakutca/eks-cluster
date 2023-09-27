resource "null_resource" "generate_config_map" {
  depends_on = [ module.eks, module.eks_vpc ]
  triggers = {
    node_role_arn = module.eks.worker_node_role_arn
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
          - rolearn: ${module.eks.worker_node_role_arn}
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


