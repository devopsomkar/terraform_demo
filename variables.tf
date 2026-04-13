
variable "instance_type" {
  description = "EC2 instance type for ECS"
  type        = string
  default     = "t3.small"
}

variable "min_size" {
  description = "Min ASG size"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Max ASG size"
  type        = number
  default     = 1
}

variable "key_name" {
  description = "EC2 Key Pair name"
  type        = string
  default     = null
}

variable "dynatrace_tenant" {
  description = "Dynatrace tenant subdomain only, for example dt0c01abc"
  type        = string
}

variable "dynatrace_token" {
  description = "Dynatrace OneAgent installer token"
  type        = string
  sensitive   = true
}
