resource "aws_ecs_cluster" "container_cluster" {
  name                = "${var.resource_name_prefix}-container-cluster"
  capacity_providers  = ["FARGATE"]
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = var.common_tags
}


resource "aws_ecs_task_definition" "container_task_definition" {
  family                   = "${var.resource_name_prefix}-container-task-definition"
  container_definitions    = data.template_file.ecs_container_definition.rendered
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_cpu_unit
  memory                   = var.task_memory
  execution_role_arn       = var.task_execution_role_arn
  tags                     = var.common_tags
}


resource "aws_ecs_service" "container_service" {
  # Configure service
  name                               = "${var.resource_name_prefix}-container-service"
  cluster                            = aws_ecs_cluster.container_cluster.id
  task_definition                    = aws_ecs_task_definition.container_task_definition.arn
  scheduling_strategy                = "REPLICA"
  desired_count                      = 1
  launch_type                        = "FARGATE"
  platform_version                   = "LATEST"
//  platform_version                   = "1.4.0"
  deployment_minimum_healthy_percent = 100
  health_check_grace_period_seconds  = var.alb_health_check_grace_period
  network_configuration {
    subnets          = var.service_subnets_id
    security_groups  = var.service_security_groups_id
    assign_public_ip = true
  }
  load_balancer {
    container_name   = var.container_name
    target_group_arn = var.ecs_target_group.arn
    container_port   = var.container_port
  }
  # Amazon ECS service requires an explicit dependency on the Application Load Balancer
  # listener rule and the Application Load Balancer listener
  depends_on = [var.alb_listener]
}
