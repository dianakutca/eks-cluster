resource "aws_eks_node_group" "my_node_group" {
  cluster_name    = aws_eks_cluster.my_cluster.name
  node_group_name = "my-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = aws_subnet.public_subnet[*].id

  capacity_type = "ON_DEMAND"  # Or use "SPOT" for spot instances

  scaling_config {
    min_size     = 1
    max_size     = 3
    desired_size = 2
  }
}
