terraform {
  backend "s3" {
    bucket = ""
    key = "dev/home/ec2-user/eks-cluster/scripts"
    region = "us-east-2"
  }
}
