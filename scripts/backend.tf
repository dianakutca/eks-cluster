terraform {
  backend "s3" {
    bucket = "terraform-project-dianakutca-eks-setup"
    key = "dev/home/ec2-user/eks-cluster/scripts"
    region = "us-east-1"
  }
}
