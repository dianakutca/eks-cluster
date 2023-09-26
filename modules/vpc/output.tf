output "private_subnet_ids" {
  value = [
    aws_subnet.private1.id,
    aws_subnet.private2.id,
    aws_subnet.private3.id
  ]
}

output "vpc_id" {
  value = aws_vpc.Vpc.id
}