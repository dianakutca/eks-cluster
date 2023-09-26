resource "aws_key_pair" "eks-key" {
  key_name   = "eks-key"
  public_key = file(var.path_to_public_key)
}