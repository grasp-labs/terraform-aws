## Introduction

Terraform supports most AWS SNS resource options except for email for email-json protocols. Because the email needs to be confirmed, it becomes out of the normal bounds of the terraform model so it does not support it. 

This module creates a SNS email topic via a CloudFormation that outputs the ARN to be used elsewhere. 

## Usage

Use the module like:
```
module "sns-email" {
  source = "git@github.com:grasp-labs/terraform-aws.git//modules/sns_email"

  display_name  = "Example: CloudWatch Alerts"
  email_addresses = ["user1@example.com", "user2@example.com"]
  stack_name    = "unique-sns-stack-name"
}
```