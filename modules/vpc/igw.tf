# Create IGW

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.eks-vpc.id

  tags = {
    Name = "IGW-${var.vpc_name}"
  }
}
