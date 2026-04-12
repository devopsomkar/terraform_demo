variable "instance_type" {
  description = "EC2 instance type for ECS"
  type        = string
  default     = "t3.micro"
}

variable "min_size" {
  description = "Min ASG size"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Max ASG size"
  type        = number
  default     = 3
}

variable "key_name" {
  description = "EC2 Key Pair name (optional)"
  type        = string
  default     = null
}

variable "dynatrace_tenant" {
  description = "Dynatrace tenant URL e.g. abc123.live.dynatrace.com"
  type        = string
  default     = "dt0c01"
}

variable "dynatrace_token" {
  description = "Dynatrace OneAgent installer token"
  type        = string
  sensitive   = true
}
