resource "aws_cloudwatch_log_group" "ecs_app" {
  name              = "/ecs/my-first-task"
  retention_in_days = 7
}

resource "aws_ecs_task_definition" "my_first_task" {
  family                   = "my-first-task"
  requires_compatibilities = ["EC2"]
  network_mode             = "bridge"
  cpu                      = "128"
  memory                   = "256"
  execution_role_arn       = var.task_exec_role_arn

  container_definitions = jsonencode([
    {
      name      = "my-first-task"
      image     = "${var.ecr_repo_url}:latest"
      essential = true
      cpu       = 128
      memory    = 256

      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs_app.name
          awslogs-region        = "ap-south-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "my_first_service" {
  name                               = "gft-test-first-service"
  cluster                            = var.cluster_id
  task_definition                    = aws_ecs_task_definition.my_first_task.arn
  scheduling_strategy                = "REPLICA"
  desired_count                      = 1
  force_new_deployment               = true
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100

  capacity_provider_strategy {
    capacity_provider = var.capacity_provider_name
    weight            = 1
  }

  depends_on = []  # Capacity provider already associated
}
