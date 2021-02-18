resource "aws_lb" "alb" {
  name               = "${var.resource_name_prefix}-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.alb_subnets_id
  tags               = var.common_tags
}


resource "aws_lb_target_group" "alb_target_group" {
  name        = "${var.resource_name_prefix}-target-group"
  vpc_id      = var.vpc_id
  target_type = "ip"
  # TODO: Need to change this to dynamic value based on input
  protocol             = local.http.protocol
  port                 = local.http.port
  deregistration_delay = var.target_deregistration_delay
  stickiness {
    type    = "lb_cookie"
    enabled = false
  }
  health_check {
    enabled  = true
    timeout  = var.alb_health_check.timeout
    interval = var.alb_health_check.interval
    path     = var.alb_health_check.path
    protocol = lookup(local.protocols, var.alb_protocol, local.http).name
    port     = lookup(local.protocols, var.alb_protocol, local.http).port
    matcher  = "200"
  }
  tags = var.common_tags
}


resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  protocol          = local.http.protocol
  port              = local.http.port
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Default Response For Load Balancer Listener."
      status_code  = "200"
    }
  }
}


resource "aws_lb_listener_rule" "alb_listener_rule" {
  listener_arn = aws_lb_listener.alb_listener.arn
  priority     = 1
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}
