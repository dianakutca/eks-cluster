resource "aws_launch_template" "eks-launch-template" {
  name_prefix = "eks-launch-template-"

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 20
    }
  }
  # instance_type = "t2.medium"


  # Add security group IDs here
  vpc_security_group_ids = aws_security_group.eks_worker_sg.id

}