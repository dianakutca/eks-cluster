module "vpc" {
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


  git config --global user.email "dianakutca14@gmail.com"
  git config --global user.name "dianakutca"