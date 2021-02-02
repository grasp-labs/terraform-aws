variable "project" {
  description = "Name of the repository."
  type        = string
}

variable "stage" {
  description = "Environment for api service. prod or dev"
  default = "dev"
}

variable "vpc_id" {
  description = "VPC for AiderPrime cluster"
  type = string
}

variable "health_check_path" {
  description = "Health check path."
  type = string
}

variable "http_enabled" {
  description = "Enable http."
  type = bool
  default = true
}

variable "security_group_ids" {
  description = "Security groups for alb resources."
  type = list(string)
}

variable "subnet_ids" {
  description = "Subnets for alb resources."
  type = list(string)
}

variable "tags" {
  description = "Default tags for alb resources."
  type = map
  default = {}
}
