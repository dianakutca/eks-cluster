terraform {
  backend "s3" {
    bucket         = "terraform-project-dianakutca-eks-setup"
    dynamodb_table = "terraform-eks-2023"
    key            = "dev/home/ec2-user/eks-cluster/tools/letsencrypt"
    region         = "us-east-1"
  }
}
