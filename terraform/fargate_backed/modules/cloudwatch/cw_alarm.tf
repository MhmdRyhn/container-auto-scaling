resource "aws_cloudwatch_metric_alarm" "request_count_per_target_scale_out_alarm" {
  alarm_name        = "${var.resource_name_prefix}-scale-out-alarm"
  alarm_description = "Scale out alarm when the number-of-request-count >= threshold"
  namespace         = "AWS/ApplicationELB"
  dimensions = {
    TargetGroup = var.alb_target_group.arn_suffix
  }
  metric_name         = "RequestCountPerTarget"
  statistic           = "Sum"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = var.request_per_server_per_minute
  period              = var.alarm_datapoint_creation_period
  evaluation_periods  = var.datapoints
  datapoints_to_alarm = var.datapoints_to_alarm
  alarm_actions       = [var.scale_out_policy.arn]
  tags                = var.common_tags
}


resource "aws_cloudwatch_metric_alarm" "request_count_per_target_scale_in_alarm" {
  alarm_name        = "${var.resource_name_prefix}-scale-in-alarm"
  alarm_description = "Scale out alarm when the number-of-request-count < threshold"
  namespace         = "AWS/ApplicationELB"
  dimensions = {
    TargetGroup = var.alb_target_group.arn_suffix
  }
  metric_name         = "RequestCountPerTarget"
  statistic           = "Sum"
  comparison_operator = "LessThanOrEqualToThreshold"
  threshold           = var.request_per_server_per_minute
  period              = var.alarm_datapoint_creation_period
  evaluation_periods  = var.datapoints
  datapoints_to_alarm = var.datapoints_to_alarm
  alarm_actions       = [var.scale_in_policy.arn]
  tags                = var.common_tags
}
