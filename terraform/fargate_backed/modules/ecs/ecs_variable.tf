variable "resource_name_prefix" {
  type        = string
  description = "A prefix that is to be used with all the resources' name."
}

variable "common_tags" {
  type        = map(string)
  description = "Tags which are common to all resources."
}

variable "container_name" {
  type = string
  description = "Name of the container."
}

variable "container_cpu_unit" {
  type        = number
  description = "CPU unit to be assigned to CONTAINER."
}

variable "container_memory_soft_limit" {
  type        = number
  description = "Soft memory (in MiB) for CONTAINER."
}

variable "container_memory_hard_limit" {
  type        = number
  description = "Hard memory (in MiB) for CONTAINER.."
}

variable "container_image" {
  type        = string
  description = "Image URL for ECR registry or the image name if it is in DockerHub."
}

variable "container_health_check" {
  type = object({
    timeout  = number
    interval = number
    retries  = number
    path     = string
  })
  description = "Health check parameters inside container."
  default = {
    timeout  = 5
    interval = 10
    retries  = 3
    path     = "/health-check"
  }
}

variable "container_port" {
  type        = number
  description = "Port in container where to accept request."
}

variable "task_cpu_unit" {
  type        = number
  description = "CPU unit to be assigned to TASK."
}

variable "task_memory" {
  type        = number
  description = "Memory (in MiB) to be assigned to TASK."
}

variable "task_execution_role_arn" {
  type        = string
  description = "ARN of the Task Execution Role."
}

variable "service_subnets_id" {
  type        = list(string)
  description = "A list of subnets id for ECS service."
}

variable "service_security_groups_id" {
  type        = list(string)
  description = "A list of security groups' id."
}

variable "ecs_target_group" {
  description = "ECS target group Resource."
}

variable "alb_listener" {
  description = "Application Load Balancer listener Resource."
}

variable "container_log_group_name" {
  type        = string
  description = "Log group for container logging."
}

variable "container_log_group_region" {
  type        = string
  description = "Log group region for container logging."
}

variable "container_log_stream_prefix" {
  type        = string
  description = "Log stream prefix for container logging."
}
