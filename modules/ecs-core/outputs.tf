output "cluster_id" {
  value = aws_ecs_cluster.my_cluster.id
}

output "cluster_name" {
  value = aws_ecs_cluster.my_cluster.name
}

output "capacity_provider_name" {
  value = aws_ecs_capacity_provider.ec2_cp.name
}
