resource "aws_cloudwatch_log_group" "container_log_group" {
  name              = "/${var.resource_name_prefix}/${var.container_log_group_name}"
  retention_in_days = 0 # Always persist
  tags              = var.common_tags
}
