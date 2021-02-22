data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

locals {
  full_name = "${var.name}-${var.env}"
  environment_map = var.env_vars == null ? [] : [var.env_vars]
}

# This is the IAM policy for letting lambda assume roles.
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = [
        "lambda.amazonaws.com"
      ]
    }
  }
}

# Define default policy document for writing to Cloudwatch Logs.
data "aws_iam_policy_document" "logs_policy_doc" {
  statement {
    sid    = "WriteCloudWatchLogs"
    effect = "Allow"

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${local.full_name}:*"]
  }
}

# Create the IAM role for the Lambda instance.
resource "aws_iam_role" "main" {
  name               = "lambda-${local.full_name}"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# Attach the logging policy to the above IAM role.
resource "aws_iam_role_policy" "main" {
  name = "lambda-${local.full_name}"
  role = aws_iam_role.main.id

  policy = data.aws_iam_policy_document.logs_policy_doc.json
}

resource "aws_iam_role_policy_attachment" "role-policy-attachment" {
  role       = aws_iam_role.main.id
  count      = length(var.iam_policy_arn)
  policy_arn = var.iam_policy_arn[count.index]
}

resource "aws_cloudwatch_log_group" "main" {
  name = "/aws/lambda/${local.full_name}"

  tags = {
    Name = local.full_name
  }
}

resource "aws_lambda_function" "main" {
  depends_on = [
    aws_cloudwatch_log_group.main]

  s3_bucket = var.s3_bucket
  s3_key    = var.s3_key

  function_name = local.full_name
  role          = aws_iam_role.main.arn
  handler       = var.handler
  runtime       = var.runtime
  memory_size   = var.memory_size
  timeout       = var.timeout

  dynamic "environment" {
    for_each = local.environment_map
    content {
      variables = environment.value
    }
  }

  tags = var.tags

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }
}
