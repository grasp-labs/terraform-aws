variable "name" {
  description = "Name of the efs"
  type = string
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnets" {
  type        = list(string)
  description = "Subnet IDs"
}

variable "ingress_security_groups" {
  type        = list(string)
  description = "Security group IDs to allow access to the EFS"
}

variable "access_points" {
  type        = map(map(map(any)))
  default     = {}
  description = "A map of the access points you would like in your EFS volume"
}