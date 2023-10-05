#create 2 security groups:for cluster and node groupx

resource "aws_security_group" "eks_cluster_sg" {
  name_prefix = "eks_cluster_sg-"
  description = "Security group for EKS cluster"
  vpc_id      = var.vpc_id[0]
}

resource "aws_security_group" "eks_worker_sg" {
  name_prefix = "eks_worker_sg-"
  description = "Security group for EKS worker nodes"
  vpc_id      = var.vpc_id[0]
}



# Ingress rule for eks_cluster_sg / Allow control plane traffic only from worker nodes, pods to communicate with the cluster API Server
resource "aws_security_group_rule" "eks_cluster_sg_ingress" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_cluster_sg.id
  source_security_group_id = aws_security_group.eks_worker_sg.id
}

# Egress rule for eks_cluster_sg,  Allow outbound traffic to the Internet (for control plane communication)
resource "aws_security_group_rule" "eks_cluster_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.eks_cluster_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

# Ingress rule to Allow inbound traffic from control plane
resource "aws_security_group_rule" "eks_worker_sg_ingress" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_worker_sg.id
  source_security_group_id = aws_security_group.eks_cluster_sg.id
}

# Allow node to communicate with each other eks_worker_sg / ingress for node group
resource "aws_security_group_rule" "eks_worker_sg_inter_node_ingress" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  security_group_id = aws_security_group.eks_worker_sg.id
  self              = true
}

#  Allow worker Kubelets and pods to receive communication from the cluster control plane /ingress for node group
resource "aws_security_group_rule" "eks_worker_sg1_kubelet_ingress" {
  type                     = "ingress"
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_worker_sg.id
  source_security_group_id = aws_security_group.eks_worker_sg.id
}

resource "aws_security_group_rule" "eks_worker_sg_kubelet_ingress" {
  type                     = "ingress"
  from_port                = 10250
  to_port                  = 10250
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks_worker_sg.id
  cidr_blocks       =       ["172.31.0.0/16"]
}


# Egress rule for eks_worker_sg, Allow outbound traffic to the Internet (for updates, package installations, etc.)
resource "aws_security_group_rule" "eks_worker_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.eks_worker_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}
