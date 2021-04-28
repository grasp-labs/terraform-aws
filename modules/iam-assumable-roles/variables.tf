variable "role_name" {
  description = "Role name"
}

variable "description" {
  description = "Description for the role"
  type = String
  default = ""
}

variable "tags" {
  description = "Tags for role."
  type = map
  default = {}
}

variable "iam_role_policy_document_json" {
  type = string

  description = "Valid JSON Policy String this can be constructed from terraform data.aws_iam_policy_document."
}

variable "policy_arns" {
  type        = list
  description = "List of policy arns to attach to this role"
  default     = []
}
