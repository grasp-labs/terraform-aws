variable "project" {
  description = "Current project."
  type        = string
}

variable "role_policy_arns" {
  description = "Policies will be attached to this role."
  type        = list(string)
  default     = []
}
