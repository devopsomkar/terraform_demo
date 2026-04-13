output "vpc_id" {
  value = aws_default_vpc.ecs_vpc.id
}

output "public_subnet_ids" {
  value = [
    aws_default_subnet.ecs_az1.id,
    aws_default_subnet.ecs_az2.id,
    aws_default_subnet.ecs_az3.id
  ]
}
