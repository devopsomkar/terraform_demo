variable "cluster_id" {
  description = "ECS cluster ID"
  type = string
}

variable "capacity_provider_name" {
  description = "ECS capacity provider name"
  type = string
}

variable "task_exec_role_arn" {
  description = "ECS task execution role ARN"
  type = string
}

variable "ecr_repo_url" {
  description = "ECR repository URL"
  type = string
}
