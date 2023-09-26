# resource "aws_lb_target_group" "eks_workers" {
#   name     = "eks-workers"
#   port     = 80  # Adjust the port as needed
#   protocol = "HTTP"  # Adjust the protocol if needed

#   vpc_id = aws_vpc.my_vpc.id  # Specify the VPC ID where the target group should be created

#   health_check {
#     path                = "/"
#     port                = 80  # Adjust the port for health checks if needed
#     protocol            = "HTTP"  # Adjust the protocol for health checks if needed
#     interval            = 30  # Adjust the interval for health checks if needed
#     timeout             = 10  # Adjust the timeout for health checks if needed
#     healthy_threshold   = 3  # Adjust the healthy threshold if needed
#     unhealthy_threshold = 3  # Adjust the unhealthy threshold if needed
#   }

#   # Additional target group attributes or tags can be added here as needed.
# }


# resource "aws_launch_template" "eks_worker" {
#   name_prefix = "eks-worker-"
#   image_id    = "ami-xxxxxxxxxxxxxxxxx"  # Replace with your desired Amazon Linux 2 AMI
#   instance_type = "t2.micro"  # Adjust instance type as needed
#   key_name     = aws_key_pair.eks-key.id 
#   security_groups = [aws_security_group.eks_worker_sg.id]
#   user_data = <<-EOF
#               #!/bin/bash
#               echo "Hello from user data!"
#               EOF
# }

# resource "aws_autoscaling_group" "eks_worker_asg" {
#   name = "eks-worker-asg"
#   min_size = 1
#   max_size = 20
#   desired_capacity = 1
#   launch_template {
#     id = aws_launch_template.eks_worker.id
#   }
#   vpc_zone_identifier = aws_subnet.private_subnets[*].id
#   target_group_arns = [aws_lb_target_group.eks_workers.arn]
# }
