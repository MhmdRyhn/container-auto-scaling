data "template_file" "ecs_container_definition" {
  template = file("${path.module}/templates/container-definition.json.tpl")
  vars = {
    container_name        = var.container_name
    host_port             = var.container_port
    container_port        = var.container_port
    cpu_unit              = var.container_cpu_unit
    hard_limit            = var.container_memory_hard_limit
    soft_limit            = var.container_memory_soft_limit
    image                 = var.container_image
    health_check_timeout  = var.container_health_check.timeout
    health_check_interval = var.container_health_check.interval
    health_check_retries  = var.container_health_check.retries
    health_check_path     = var.container_health_check.path
    log_group_name        = aws_cloudwatch_log_group.container_log_group.name
    log_group_region      = var.container_log_group_region
    log_stream_prefix     = var.container_log_stream_prefix
  }
}
