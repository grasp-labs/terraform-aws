resource "aws_iam_role" "this" {
  name               = var.role_name
  assume_role_policy = var.iam_role_policy_document_json
}

resource "aws_iam_role_policy_attachment" "attachment" {
  count      = length(var.policy_arns)
  role       = aws_iam_role.this.name
  policy_arn = var.policy_arns[count.index]
}
