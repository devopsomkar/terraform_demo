locals {
  dynatrace_url = "https://${var.dynatrace_tenant}.live.dynatrace.com"
}

resource "aws_iam_role_policy" "dynatrace_ec2_read" {
  name = "dynatrace-ec2-read"
  role = var.ecs_instance_role_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ec2:Describe*",
          "cloudwatch:Get*"
        ]
        Resource = "*"
      }
    ]
  })
}

output "dynatrace_url" {
  value = local.dynatrace_url
}
