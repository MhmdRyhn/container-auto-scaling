provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}


module "alb" {
  source               = "./modules/alb"
  resource_name_prefix = local.resource_name_prefix
  common_tags          = local.common_tags
  vpc_id               = "vpc-1673956f"
  alb_subnets_id       = ["subnet-7d9ac91b", "subnet-7f7c5e37"]
  alb_protocol         = "http"
  alb_health_check = {
    timeout  = 5
    interval = 10
    protocol = "http"
    path     = "/health-check"
  }
}


module "ecs" {
  source                      = "./modules/ecs"
  resource_name_prefix        = local.resource_name_prefix
  common_tags                 = local.common_tags
  container_name              = "fargate-container"
  container_cpu_unit          = 512
  container_memory_soft_limit = 1024
  container_memory_hard_limit = 2048
  container_image             = "${data.aws_caller_identity.this.account_id}.dkr.ecr.eu-west-1.amazonaws.com/container-auto-scaling:latest"
  container_health_check = {
    timeout  = 5
    interval = 10
    retries  = 3
    path     = "/health-check"
  }
  container_port              = 80
  task_cpu_unit               = 1024
  task_memory                 = 2048
  task_execution_role_arn     = "arn:aws:iam::${data.aws_caller_identity.this.account_id}:role/ecsTaskExecutionRole"
  service_subnets_id          = ["subnet-7d9ac91b", "subnet-7f7c5e37"]
  service_security_groups_id  = ["sg-0fee0b4e690ca603d"]
  alb_health_check_grace_period = 60
  ecs_target_group            = module.alb.alb_target_group
  alb_listener                = module.alb.alb_listener
  container_log_group_name    = "${local.resource_name_prefix}/ecs-container-logs"
  container_log_group_region  = var.aws_region
  container_log_stream_prefix = local.resource_name_prefix
}
