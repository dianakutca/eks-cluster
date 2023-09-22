# Create NAT Gateway
resource "aws_nat_gateway" "NATgw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public1.id

  tags = {
    Name = "NATGW-${var.vpc_name}"
  }
}

# # Create Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "EIP-${var.vpc_name}"
  }
}