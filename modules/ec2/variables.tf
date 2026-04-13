variable "vpc_id" {
  description = "VPC ID for EC2"
  type = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for ASG"
  type = list(string)
}

variable "ecs_instance_profile_name" {
  description = "IAM instance profile name"
  type = string
}

variable "cluster_name" {
  description = "ECS cluster name for userdata"
  type = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type = string
}

variable "key_name" {
  description = "EC2 key pair"
  type = string
  default = null
}

variable "min_size" {
  description = "ASG min size"
  type = number
}

variable "max_size" {
  description = "ASG max size"
  type = number
}
