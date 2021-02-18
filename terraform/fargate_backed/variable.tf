variable "aws_profile" {
  type        = string
  description = "Name of the profile stored in ~/.aws/credentials file."
}

variable "aws_region" {
  type        = string
  description = "Name of the aws region."
  default     = "ap-southeast-1" // Singapore
}

variable "prefix" {
  type        = string
  description = "A prefix that is to be used with the resource name. Usually, this should be the application name."
}

variable "service" {
  type        = string
  description = "Name of the service. E.g., admin, auth, payment, reporting etc."
  default     = ""
}

variable "environment" {
  type        = string
  description = "Environment name, e.g., Dev, Test, Stage, UAT, Prod etc."
}

# Variables for ./modules/alb
variable "vpc_id" {
  type        = string
  description = "VPC id"
}

variable "alb_subnets_id" {
  type        = list(string)
  description = "A list of subnets id from the provided VPC."
}

variable "alb_protocol" {
  type        = string
  description = "Protocol used in ALB"
  default     = "http"
}

variable "alb_health_check_params" {
  type = object({
    timeout  = number
    interval = number
    protocol = string
    path     = string
  })
}

# Variables for ./modules/ecs
variable "container_name" {
  type        = string
  description = "Name used for the container."
}

variable "container_cpu_unit" {
  type        = number
  description = "CPU unit for the container. 1024 CPU Unit is equal to 1 vCPU."
}

variable "container_memory_soft_limit" {
  type        = number
  description = "Memory in MiB"
}

variable "container_memory_hard_limit" {
  type        = number
  description = "Memory in MiB"
}

variable "container_image" {
  type        = string
  description = "This can be container name for public images. Or, the image URL with tag for private URL."
}

variable "container_health_check_params" {
  type = object({
    timeout  = number
    interval = number
    retries = number
    path     = string
  })
}

variable "container_port" {
  type        = number
  description = "Port inside container to be opened."
}

variable "task_cpu_unit" {
  type        = number
  description = "CPU unit for the task. 1024 CPU Unit is equal to 1 vCPU."
}

variable "task_memory" {
  type        = number
  description = "Memory in MiB"
}

variable "task_execution_role_name" {
  type        = string
  description = "Task execution role name."
}

variable "service_subnets_id" {
  type        = list(string)
  description = "A list of subnets id from the provided VPC."
}

variable "service_security_groups_id" {
  type        = list(string)
  description = "A list of security groups."
}

variable "alb_health_check_grace_period" {
  type        = number
  description = "Time to ignore the health check failure from the beginning."
}

variable "container_log_group_name" {
  type        = string
  description = "Name of the log group for the container"
}

variable "container_log_stream_prefix" {
  type        = string
  description = "Prefix to be used in log stream name."
}
