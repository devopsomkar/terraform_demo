data "aws_ami" "ecs_optimized" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}



resource "aws_launch_template" "ecs_launch_template" {
  name_prefix            = "ecs-template-"
  image_id               = data.aws_ami.ecs_optimized.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.ecs.id]
  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_instance_profile.name
  }

  user_data = base64encode(templatefile("${path.module}/userdata.sh", {
    cluster_name     = aws_ecs_cluster.my_cluster.name
    dynatrace_tenant = var.dynatrace_tenant
    dynatrace_token  = var.dynatrace_token
  }))

  lifecycle {
    create_before_destroy = true
  }
}

# Security group for EC2 (basic)
resource "aws_security_group" "ecs" {
  name_prefix = "ecs-sg-"
  vpc_id      = aws_default_vpc.ecs-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_autoscaling_group" "ecs_asg" {
  name                      = "ecs-asg"
  vpc_zone_identifier       = [aws_default_subnet.ecs_az1.id, aws_default_subnet.ecs_az2.id, aws_default_subnet.ecs_az3.id]
  min_size                  = var.min_size
  max_size                  = var.max_size
  health_check_type         = "EC2"
  health_check_grace_period = 300
  protect_from_scale_in     = true

  launch_template {
    id      = aws_launch_template.ecs_launch_template.id
    version = "$Latest"
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}



