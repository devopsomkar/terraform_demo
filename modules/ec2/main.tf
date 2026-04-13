data "aws_ssm_parameter" "ecs_optimized_al2023" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2023/recommended/image_id"
}

resource "aws_security_group" "ecs" {
  name_prefix = "ecs-sg-"
  vpc_id      = var.vpc_id

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

resource "aws_launch_template" "ecs_launch_template" {
  name_prefix            = "ecs-template-"
  image_id               = data.aws_ssm_parameter.ecs_optimized_al2023.value
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.ecs.id]
  update_default_version = true

  iam_instance_profile {
    name = var.ecs_instance_profile_name
  }

  user_data = base64encode(templatefile("${path.module}/../../userdata.sh.tftpl", {
    cluster_name = var.cluster_name
  }))

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "ecs_asg" {
  name = "ecs-asg"

  vpc_zone_identifier = var.public_subnet_ids

  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = 2
  health_check_type         = "EC2"
  health_check_grace_period = 300
  protect_from_scale_in     = true

  launch_template {
    id      = aws_launch_template.ecs_launch_template.id
    version = "$Latest"
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = "true"
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = "ecs-ec2-instance"
    propagate_at_launch = true
  }

  instance_refresh {
    strategy = "Rolling"

    preferences {
      min_healthy_percentage      = 50
      instance_warmup             = 60
      scale_in_protected_instances = "Refresh"
    }

    triggers = ["launch_template"]
  }
}
