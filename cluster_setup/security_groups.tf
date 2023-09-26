resource "aws_security_group" "eks_cluster_sg" {
  name_prefix = "eks_cluster_sg-"
  description = "Security group for EKS cluster"
  vpc_id      = aws_vpc.my_vpc.id

  # Allow control plane traffic only from worker nodes
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [aws_security_group.eks_worker_sg.id]
  }

  # Allow outbound traffic to the Internet (for control plane communication)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "eks_worker_sg" {
  name_prefix = "eks_worker_sg-"
  description = "Security group for EKS worker nodes"
  vpc_id      = aws_vpc.my_vpc.id

  # Allow inbound traffic from control plane
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [aws_security_group.eks_cluster_sg.id]
  }

  # Allow inbound traffic from other worker nodes (for inter-node communication)
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    self        = true
  }

  # Allow outbound traffic to the Internet (for updates, package installations, etc.)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
