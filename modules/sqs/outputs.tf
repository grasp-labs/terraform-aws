output "sqs_id" {
  description = "The URL for the created Amazon SQS queue"
  value = aws_sqs_queue.this.id
}