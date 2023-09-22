resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.Vpc.id
  cidr_block              = var.public_subnet1
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.Vpc.id
  cidr_block              = var.public_subnet2
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public2"
  }
}

resource "aws_subnet" "public3" {
  vpc_id                  = aws_vpc.Vpc.id
  cidr_block              = var.public_subnet3
  availability_zone       = "${var.region}c"
  map_public_ip_on_launch = true
  tags = {
    Name = "Public3"
  }
}



# Attach Internet Gateway to Public Subnets through route table

resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public_subnet_rt.id
}

resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public_subnet_rt.id
}

resource "aws_route_table_association" "public3" {
  subnet_id      = aws_subnet.public3.id
  route_table_id = aws_route_table.public_subnet_rt.id
}