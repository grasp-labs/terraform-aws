variable "name" {
  description = "Lambda function name"
  type        = string
}

variable "env" {
  description = "Identifier for specific instance of Lambda function"
  type        = string
  default     = "dev"
}

variable "runtime" {
  description = "Lambda runtime type"
  type        = string
  default     = "python3.7"
}

variable "s3_bucket" {
  description = "Name of s3 bucket used for Lambda build"
  type        = string
}

variable "s3_key" {
  description = "Key for s3 object for Lambda function code"
  type        = string
}

variable "memory_size" {
  default     = 128
  description = "Size in MB of Lambda function memory allocation"
  type        = string
}

variable "timeout" {
  default     = 60
  description = "Timeout in seconds for Lambda function timeout"
  type        = string
}

variable "subnet_ids" {
  default     = []
  description = "List of subnet IDs for Lambda VPC config (leave empty if no VPC)"
  type        = list(string)
}

variable "security_group_ids" {
  default     = []
  description = "List of security group IDs for Lambda VPC config (leave empty if no VPC)"
  type        = list
}

variable "handler" {
  default     = "lambda_handler"
  description = "The entrypoint function for the lambda function."
  type        = string
}

variable "iam_policy_arn" {
  description = "IAM Policy to be attached to role"
  type        = list
  default     = []
}

variable "env_vars" {
  description = "Map of environment variables for Lambda function"
  type        = map
  default     = null
}

variable "sqs_event" {
  description = "SQS queue which triggers the lambda function"
  type        = string
  default     = null
}

variable "cloudwatch_enabled" {
  description = "Enabled cloud watch trigger"
  type        = bool
  default     = false
}

variable "schedule_expression" {
  description = "Scheduling expression for triggering the Lambda Function using CloudWatch events. For example, cron(0 20 * * ? *) or rate(5 minutes)."
}

variable "tags" {
  default     = {}
  description = "Map of tags for Lambda function"
  type        = map
}


