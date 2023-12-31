output "vpc_id" {
  value = module.eks_vpc.vpc_id
}

output "private_subnet_ids" {
  value = module.eks_vpc.private_subnet_ids
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks.cluster_security_group_id
}

output "region" {
  description = "AWS region"
  value       = module.eks.region
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}


output "worker_node_role_arn" {
  value = module.eks.worker_node_role_arn
}

output "eks_oidc_url" {
  description = "The OIDC provider URL for the EKS cluster"
  value       = module.eks.identity[0].oidc[0].issuer
}


output "oidc_provider" {
  value = module.eks.oidc_provider
}
