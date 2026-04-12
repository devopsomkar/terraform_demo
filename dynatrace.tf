# dynatrace.tf - Dynatrace OneAgent for EC2 metrics (infra monitoring)

# Uses vars from variables.tf / terraform.tfvars
# OneAgent installed via userdata.sh template in ec2.tf

locals {
  dynatrace_url = "https://${var.dynatrace_tenant}.live.dynatrace.com"
}

output "dynatrace_url" {
  value = local.dynatrace_url
}

# Additional Dynatrace IAM perms if needed (optional)
resource "aws_iam_role_policy" "dynatrace_ec2_read" {
  name = "dynatrace-ec2-read"
  role = aws_iam_role.ecsInstanceRole.id

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
