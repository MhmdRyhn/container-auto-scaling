resource "aws_appautoscaling_target" "container_auto_scaling_target" {
  min_capacity       = var.scaling_min_capacity
  max_capacity       = var.scaling_max_capacity
  resource_id        = var.scaling_target_resource_id
  service_namespace  = var.scaling_service_namespace
  scalable_dimension = var.scalable_dimension
}


resource "aws_appautoscaling_policy" "container_scale_out_policy" {
  name               = "${var.resource_name_prefix}-container-scale-out-policy"
  resource_id        = var.scaling_target_resource_id
  service_namespace  = var.scaling_service_namespace
  scalable_dimension = var.scalable_dimension
  policy_type        = "StepScaling"
  step_scaling_policy_configuration {
    adjustment_type         = "ExactCapacity"
    metric_aggregation_type = "Average"
    step_adjustment {
      metric_interval_lower_bound = 0
      metric_interval_upper_bound = var.scaling_step_size
      scaling_adjustment          = 2
    }
    step_adjustment {
      metric_interval_lower_bound = var.scaling_step_size
      metric_interval_upper_bound = var.scaling_step_size * 2
      scaling_adjustment          = 3
    }
    step_adjustment {
      metric_interval_lower_bound = var.scaling_step_size * 2
      metric_interval_upper_bound = var.scaling_step_size * 3
      scaling_adjustment          = 4
    }
    step_adjustment {
      metric_interval_lower_bound = var.scaling_step_size * 3
      metric_interval_upper_bound = var.scaling_step_size * 4
      scaling_adjustment          = 5
    }
    step_adjustment {
      metric_interval_lower_bound = var.scaling_step_size * 4
      # metric_interval_upper_bound = +infinity
      scaling_adjustment = 6
    }
    # There can be more and more `step_adjustment` block
  }
}


resource "aws_appautoscaling_policy" "container_scale_in_policy" {
  name               = "${var.resource_name_prefix}-container-scale-in-policy"
  resource_id        = var.scaling_target_resource_id
  service_namespace  = var.scaling_service_namespace
  scalable_dimension = var.scalable_dimension
  policy_type        = "StepScaling"
  step_scaling_policy_configuration {
    adjustment_type         = "ExactCapacity"
    metric_aggregation_type = "Average"
    step_adjustment {
      metric_interval_lower_bound = -(var.scaling_step_size + 1)
      metric_interval_upper_bound = -1
      scaling_adjustment          = 1
    }
    step_adjustment {
      # metric_interval_lower_bound = -infinity
      metric_interval_upper_bound = -(var.scaling_step_size + 1)
      scaling_adjustment          = 0
    }
  }
}

