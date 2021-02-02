data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "_" {
  name = "${var.project}_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json

  description = "Role to allow task definitions to execute role policies and obtain SSM parameters"
  tags = {
    service: var.project
  }
}

resource "aws_iam_role_policy_attachment" "admin" {
  count = length(var.role_policy_arns)

  role       = aws_iam_role._.name
  policy_arn = element(var.role_policy_arns, count.index)
}
