module "eks_vpc" {
  vpc_name        = ""
  source          = "../modules/vpc"
  region          = ""
  cidr_block      = ""
  public_subnet1  = ""
  public_subnet2  = ""
  public_subnet3  = ""
  private_subnet1 = ""
  private_subnet2 = ""
  private_subnet3 = ""
}