resource "aws_eks_cluster" "cluster" {
  name     = "eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn
  vpc_config {
    subnet_ids = module.vpc.private_subnet_ids
  }
}