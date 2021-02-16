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
