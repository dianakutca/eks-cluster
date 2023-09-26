#  Add Route Table for Public Subnets

resource "aws_route_table" "public_subnet_rt" {
  vpc_id = aws_vpc.eks_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name = "Public_RT"
  }
}



#  Build route table for private subnets
resource "aws_route_table" "private_subnet_rt" {
  vpc_id = aws_vpc.eks_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NATgw.id
  }
  tags = {
    Name = "Private_RT"
  }
}