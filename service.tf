
resource "aws_ecs_service" "my_first_service" {
  name                               = "gft-test-first-service"
  cluster                            = aws_ecs_cluster.my_cluster.id
  task_definition                    = aws_ecs_task_definition.my_first_task.arn
  scheduling_strategy                = "REPLICA"
  desired_count                      = 1
  force_new_deployment               = true
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.ec2_cp.name
    weight            = 1
  }

  depends_on = [
    aws_ecs_capacity_provider.ec2_cp
  ]
}
