# data "terraform_remote_state" "eks_output" {
#   backend = "s3"  # Use the appropriate backend configuration
#   config = {
#     bucket         = "terraform-project-dianakutca-eks-setup"
#     key            = "dev/home/ec2-user/eks-cluster/terraform.tfstate"
#     region         = "us-east-1"  # Replace with the correct region
#   }
# }

# resource "null_resource" "generate_config_map" {
#   depends_on = [aws_iam_role.eks_worker_role] 
#   triggers = {
#     node_role_arn = data.terraform_remote_state.eks_output.outputs.worker_node_role_arn
#     cluster_name  = var.cluster-name
#   }

#   provisioner "local-exec" {
#     command = <<-EOT
#       cat <<EOF > config-map-aws-auth.yaml
#       apiVersion: v1
#       kind: ConfigMap
#       metadata:
#         name: aws-auth
#         namespace: kube-system
#       data:
#         mapRoles: |
#           - rolearn: ${data.terraform_remote_state.eks_output.outputs.worker_node_role_arn}
#             username: system:node:{{EC2PrivateDNSName}}
#             groups:
#               - system:bootstrappers
#               - system:nodes
#       EOF
#     EOT
#   }
# }


