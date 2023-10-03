module "eks" {
  source             = "../modules/eks"
  region             = "us-east-2"
  path_to_public_key = "/home/ec2-user/.ssh/id_rsa.pub"
  cluster-name       = "terraform-eks-dev"
  vpc_id             = module.eks_vpc.vpc_id
  subnet_ids         = module.eks_vpc.private_subnet_ids
}