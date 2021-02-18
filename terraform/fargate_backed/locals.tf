locals {
  resource_name_prefix = "${var.prefix}${var.service == "" ? "" : "-"}${var.service}-${var.environment}"
  common_tags = merge(
    {
      Application = var.prefix
      Environemnt = var.environment
    },
    zipmap(
      compact([var.service == "" ? "" : "Service"]),
      compact([var.service])
    )
  )
}

locals {
  http = {
    protocol = "HTTP"
    port     = 80
  }
}

locals {
  container_image         = "${data.aws_caller_identity.this.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.container_image}"
  task_execution_role_arn = "arn:aws:iam::${data.aws_caller_identity.this.account_id}:role/ecsTaskExecutionRole"
  //  container_log_group_name    = "/${local.resource_name_prefix}/${var.container_log_group_name}"
  container_log_stream_prefix = "${local.resource_name_prefix}/${var.container_log_stream_prefix != "" ? var.container_log_stream_prefix : ""}${var.container_log_stream_prefix}"
}
