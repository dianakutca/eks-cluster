resource "aws_key_pair" "eks-key" {
  key_name   = ""
  public_key = file(var.path_to_public_key)
}