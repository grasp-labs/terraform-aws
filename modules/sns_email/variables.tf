variable "display_name" {
    type = string
    description = "Name shown in confirmation emails"
}

variable "emails" {
    type = list(string)
    description = "Email addresses to send notification to"
}

variable "stack_name" {
    type = string
    description = "Unique Cloudformation stack name that wraps the SNS topic"
}