module "eks" {
  source             = "../modules/eks"
  region             = ""
  path_to_public_key = ""
  cluster-name       = ""
  vpc_id             = module.eks_vpc.vpc_id
  subnet_ids         = module.eks_vpc.private_subnet_ids
}