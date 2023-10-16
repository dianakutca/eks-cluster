terraform {
  backend "s3" {
    bucket         = ""
    dynamodb_table = ""
    key            = "dev/home/ec2-user/eks-cluster/"
    region         = "us-east-1"
  }
}
