resource "aws_ecs_service" "my_first_services" {
  name                = "gft-test-first-services"
  cluster             = aws_ecs_cluster.my_cluster.id
  task_definition     = aws_ecs_task_definition.my_first_task.arn
  scheduling_strategy = "REPLICA"
  desired_count       = 1

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.ec2_cp.name
    weight            = 1
  }

  network_configuration {
    subnets          = [aws_default_subnet.ecs_az1.id]
    assign_public_ip = false
  }
}
