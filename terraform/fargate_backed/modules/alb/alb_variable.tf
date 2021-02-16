variable "resource_name_prefix" {
  type        = string
  description = "A prefix that is to be used with all the resources' name."
}

variable "common_tags" {
  type        = map(string)
  description = "Tags which are common to all resources."
}

variable "vpc_id" {
  type        = string
  description = "Id of the VPC where ALB will exists."
}

variable "alb_subnets_id" {
  type        = list(string)
  description = "A list of subnets id for Application Load Balancer."
}

variable "alb_protocol" {
  type        = string
  description = "Protocol used in alb resources."
}

variable "alb_health_check" {
  type = object({
    timeout  = number
    interval = number
    protocol = string
    path     = string
  })
  description = "ALB target group health check parameters."
  default = {
    timeout  = 5
    interval = 10
    protocol = "HTTP"
    path     = "/health-check"
  }
}
