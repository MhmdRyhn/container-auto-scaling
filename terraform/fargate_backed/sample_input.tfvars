# Common variables
aws_profile = "dev"
aws_region  = "eu-west-1"
prefix      = "learning"
service     = ""
environment = "test"
# For the "./modules/alb" module
vpc_id         = "vpc-1234567a"
alb_subnets_id = ["subnet-1a2b3c4d", "subnet-2a3b4c5d"]
alb_protocol   = "http"
alb_health_check_params = {
  timeout  = 5
  interval = 10
  protocol = "http"
  path     = "/health"
}
# For the "./modules/ecs" module
container_name              = "fargate-container"
container_cpu_unit          = 512 // 0.5 vCPU
container_memory_soft_limit = 1024
container_memory_hard_limit = 2048
container_image             = "container-auto-scaling:latest"
container_health_check_params = {
  timeout  = 5
  interval = 10
  retries  = 3
  path     = "/health"
}
container_port                = 80
task_cpu_unit                 = 1024 // 1 vCPU
task_memory                   = 2048
task_execution_role_name      = "ecsTaskExecutionRole"
service_subnets_id            = ["subnet-1a2b3c4d", "subnet-2a3b4c5d"]
service_security_groups_id    = ["sg-1a2b3c4d5e6f7a8b9"]
alb_health_check_grace_period = 60
container_log_group_name      = "ecs-container-log-group"
container_log_stream_prefix   = "ecs-container-log-stream"
