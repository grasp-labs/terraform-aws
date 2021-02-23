resource "aws_sqs_queue" "this" {
  name                        = var.name
  visibility_timeout_seconds  = var.visibility_timeout_seconds
  message_retention_seconds   = var.message_retention_seconds
  max_message_size            = var.max_message_size
  delay_seconds               = var.delay_seconds
  receive_wait_time_seconds   = var.receive_wait_time_seconds
  policy                      = var.policy
  content_based_deduplication = var.content_based_deduplication

  tags = var.tags
}

resource "aws_iam_policy" "producer" {
  name = "sqs-${var.name}-producer"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sqs:SendMessage",
                "sqs:SendMessageBatch"
            ],
            "Resource": "${aws_sqs_queue.this.arn}"
        }
    ]
}
EOF
}

resource "aws_iam_policy" "consumer" {
  name = "sqs-${var.name}-consumer"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sqs:DeleteMessage",
                "sqs:DeleteMessageBatch",
                "sqs:ReceiveMessage",
                "sqs:GetQueueAttributes"
            ],
            "Resource": "${aws_sqs_queue.this.arn}"
        }
    ]
}
EOF
}


resource "aws_sqs_queue_policy" "_" {
  queue_url = aws_sqs_queue.this.id

  policy = <<POLICY
  {
    "Id": "Policy1604150115337",
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sqs:*",
        "Effect": "Allow",
        "Resource": "${aws_sqs_queue.this.arn}",
      }
    ]
  }
POLICY
}