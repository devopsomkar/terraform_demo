output "cluster_name" {
  value = aws_ecs_cluster.my_cluster.name
}

output "service_arn" {
  value = aws_ecs_service.my_first_services.arn
}

output "ecr_url" {
  value = aws_ecr_repository.my_first_ecr_repo.repository_url
}

output "asg_name" {
  value = aws_autoscaling_group.ecs_asg.name
}

output "dynatrace_tenant" {
  value     = var.dynatrace_tenant
  sensitive = true
}
