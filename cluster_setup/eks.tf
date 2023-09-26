module "eks" {
  source             = "../modules/eks"
  region             = "us-east-1"
  path_to_public_key = "/home/ec2-user/.ssh/id_rsa.pub"
  cluster-name       = "terraform-eks-dev"
  vpc_id             = module.eks-vpc.vpc_id
  subnet_ids = module.eks-vpc.private_subnet_ids
}