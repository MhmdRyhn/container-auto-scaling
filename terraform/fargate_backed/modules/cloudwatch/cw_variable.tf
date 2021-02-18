variable "resource_name_prefix" {
  type        = string
  description = "A prefix that is to be used with all the resources' name."
}

variable "common_tags" {
  type        = map(string)
  description = "Tags which are common to all resources."
}

variable "alb_target_group" {
  # type = resource
  description = "ALB target group resource."
}

variable "request_per_server_per_minute" {
  type = number
  description = "Number of request a server can handle per minute."
}

variable "alarm_datapoint_creation_period" {
  # evaluation interval = datapoints * period
  #
  # >> period, datapoints/evaluation periods, datapoints_to_alarm can be different for scale out and scale in policies.
  type        = number
  description = "Length of time (in seconds) to evaluate the metric to create each individual data point."
  default     = 60 // 60 Seconds
}

variable "datapoints" {
  # Also known as `Evaluation Periods`
  # evaluation interval = datapoints * period
  #
  # >> period, datapoints/evaluation periods, datapoints_to_alarm can be different for scale out and scale in policies.
  type        = number
  description = "Number of the most recent data points within metric evaluation period when determining alarm state."
  default     = 1
}

variable "datapoints_to_alarm" {
  # This MUST be less than or equal to the `datapoints`. Otherwise, the alarm will never go into ALARM state.
  #
  # Let, datapoints_to_alarm = M, datapoints = N, period = P.
  # If I configure M out of N datapoints with a period of P, then if M datapoints breaches the threshold
  # within the evaluation inerval (N * P), then the alarm goes into ALARM state.
  #
  # >> period, datapoints/evaluation periods, datapoints_to_alarm can be different for scale out and scale in policies.
  type        = string
  description = "The number of data points within the Evaluation Periods that must be breaching to cause the alarm to go to the ALARM state."
}

variable "scale_out_policy" {
  # type = "resource"
  description = "Scale out policy resource."
}

variable "scale_in_policy" {
  # type = "resource"
  description = "Scale in policy resource."
}
