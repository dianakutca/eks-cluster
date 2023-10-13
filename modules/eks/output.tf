output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = aws_eks_cluster.cluster.endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = aws_security_group.eks_cluster_sg.id
}

output "region" {
  description = "AWS region"
  value       = var.region
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = var.cluster-name
}


output "worker_node_role_arn" {
  value = aws_iam_role.eks_worker_role.arn
}


output "eks_oidc_url" {
  description = "The OIDC provider URL for the EKS cluster"
  value       = aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

output "identity" {
  description = "Identity attributes of the EKS Cluster"
  value       = aws_eks_cluster.cluster.identity
}


output oidc_provider {
  value = aws_iam_openid_connect_provider.eks.arn
}