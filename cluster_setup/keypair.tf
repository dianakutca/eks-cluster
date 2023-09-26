resource "aws_key_pair" "eks-key" {
  key_name   = "eks-key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}