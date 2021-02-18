output "scale_out_policy" {
  value = aws_appautoscaling_policy.container_scale_out_policy
}

output "scale_in_policy" {
  value = aws_appautoscaling_policy.container_scale_in_policy
}
