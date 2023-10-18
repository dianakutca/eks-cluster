resource "aws_iam_role" "dns_manager" {
  name               = "dns-manager"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Principal = {
          Service = "route53.amazonaws.com"
        },
        Action    = "sts:AssumeRole"
      }
    ]
  })
}
resource "aws_iam_role_policy" "route53_full_access" {
  name   = "Route53FullAccess"
  role   = aws_iam_role.dns_manager.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "route53:*",
        Resource = "*"
      }
    ]
  })
}

output "role_arn" {
  description = "The ARN of the dns-manager role"
  value       = aws_iam_role.dns_manager.arn
}


