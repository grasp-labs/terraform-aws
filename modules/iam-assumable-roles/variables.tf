variable "role_name" {
  description = "Role name"
}

variable "iam_role_policy_document_json" {
  type = "string"

  description = "Valid JSON Policy String this can be constructed from terraform data.aws_iam_policy_document."
}

variable "policy_arns" {
  type        = list
  description = "List of policy arns to attach to this role"
  default     = []
}
