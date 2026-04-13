output "ecs_task_exec_role_arn" {
  value = aws_iam_role.ecsTaskExecutionRole.arn
}

output "ecs_instance_profile_name" {
  value = aws_iam_instance_profile.ecs_instance_profile.name
}
