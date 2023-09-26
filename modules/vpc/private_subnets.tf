resource "aws_subnet" "private1" {
  vpc_id                  = aws_vpc.eks-vpc.id
  cidr_block              = var.private_subnet1
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = false
  tags = {
    Name = "Private1"
  }
}

resource "aws_subnet" "private2" {
  vpc_id                  = aws_vpc.eks-vpc.id
  cidr_block              = var.private_subnet2
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = false
  tags = {
    Name = "Private2"
  }
}

resource "aws_subnet" "private3" {
  vpc_id                  = aws_vpc.eks-vpc.id
  cidr_block              = var.private_subnet3
  availability_zone       = "${var.region}c"
  map_public_ip_on_launch = false
  tags = {
    Name = "Private3"
  }
}

# # Associate Private Subnets with Route Table
resource "aws_route_table_association" "Private1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private_subnet_rt.id
}

resource "aws_route_table_association" "Private2" {
  subnet_id      = aws_subnet.private2.id
  route_table_id = aws_route_table.private_subnet_rt.id
}

resource "aws_route_table_association" "Private3" {
  subnet_id      = aws_subnet.private3.id
  route_table_id = aws_route_table.private_subnet_rt.id
}