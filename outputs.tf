output "cluster_name" {
  value = module.ecs_core.cluster_name
}

output "service_arn" {
  value = module.ecs_app.service_arn
}

output "ecr_url" {
  value = module.ecr.repository_url
}

output "asg_name" {
  value = module.ec2.asg_arn
}

output "dynatrace_tenant" {
  value     = var.dynatrace_tenant
  sensitive = true
}

output "access_note" {
  value = "Open the public IP of the EC2 instance on http://<ec2-public-ip>:80"
}

output "dynatrace_url" {
  value = "https://${var.dynatrace_tenant}.live.dynatrace.com"
}
