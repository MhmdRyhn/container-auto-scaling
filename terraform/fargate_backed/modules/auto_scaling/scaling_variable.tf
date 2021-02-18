variable "resource_name_prefix" {
  type        = string
  description = "A string used as the prefix for resources' name."
}

variable "scaling_min_capacity" {
  type        = number
  description = "Min capacity for autoscaling."
}

variable "scaling_max_capacity" {
  type        = number
  description = "Max capacity for autoscaling."
}

variable "scaling_target_resource_id" {
  type        = string
  description = "Target resource id for auto-scaling."
}

variable "scaling_service_namespace" {
  type        = string
  description = "Service namespace."
  default     = "ecs"
}

variable "scalable_dimension" {
  type        = string
  description = "Scalable dimention. It's related to `Service Namespace`."
  default     = "ecs:service:DesiredCount"
}

variable "scaling_step_size" {
  type        = number
  description = "Step size for automatic scaling out/in. This should be the number of requests a server can handle per minute."
}
