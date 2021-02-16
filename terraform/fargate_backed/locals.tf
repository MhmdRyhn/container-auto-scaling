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
