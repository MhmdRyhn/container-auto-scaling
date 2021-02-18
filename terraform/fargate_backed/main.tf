provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}


module "alb" {
  source               = "./modules/alb"
  resource_name_prefix = local.resource_name_prefix
  common_tags          = local.common_tags
  vpc_id               = var.vpc_id
  alb_subnets_id       = var.alb_subnets_id
  alb_protocol         = var.alb_protocol
  alb_health_check     = var.alb_health_check_params
}

module "ecs" {
  source                        = "./modules/ecs"
  resource_name_prefix          = local.resource_name_prefix
  common_tags                   = local.common_tags
  container_name                = var.container_name
  container_cpu_unit            = var.container_cpu_unit
  container_memory_soft_limit   = var.container_memory_soft_limit
  container_memory_hard_limit   = var.container_memory_hard_limit
  container_image               = local.container_image
  container_health_check        = var.container_health_check_params
  container_port                = var.container_port
  task_cpu_unit                 = var.task_cpu_unit
  task_memory                   = var.task_memory
  task_execution_role_arn       = local.task_execution_role_arn
  service_subnets_id            = var.service_subnets_id
  service_security_groups_id    = var.service_security_groups_id
  alb_health_check_grace_period = var.alb_health_check_grace_period
  ecs_target_group              = module.alb.alb_target_group
  alb_listener                  = module.alb.alb_listener
  container_log_group_name      = local.container_log_group_name
  container_log_group_region    = var.aws_region
  container_log_stream_prefix   = local.container_log_stream_prefix
}

module "auto_scaling" {
  source                     = "./modules/auto_scaling"
  resource_name_prefix       = local.resource_name_prefix
  scaling_min_capacity       = 1
  scaling_max_capacity       = 10
  scaling_target_resource_id = "service/${module.ecs.ecs_cluster.name}/${module.ecs.ecs_service.name}"
  //  scaling_service_namespace = ""
  //  scalable_dimension = ""
  scaling_step_size = 5
}

module "alarm" {
  source                          = "./modules/cloudwatch"
  resource_name_prefix            = local.resource_name_prefix
  common_tags                     = local.common_tags
  alb_target_group                = module.alb.alb_target_group
  request_per_server_per_minute   = 5
  alarm_datapoint_creation_period = 60
  datapoints                      = 1
  datapoints_to_alarm             = 1
  scale_out_policy                = module.auto_scaling.scale_out_policy
  scale_in_policy                 = module.auto_scaling.scale_in_policy
}
