output "asg_arn" {
  value = aws_autoscaling_group.ecs_asg.arn
}

output "sg_id" {
  value = aws_security_group.ecs.id
}
