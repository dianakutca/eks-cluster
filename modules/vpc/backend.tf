terraform {
  backend "s3" {
    bucket = "terraform-project-dianakutca-eks-setup"
    key    = "dev/home/ec2-user/eks-cluster/terraform.tfstate"
    region = "us-east-1"
  }
}
