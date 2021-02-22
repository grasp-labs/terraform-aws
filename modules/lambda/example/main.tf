provider "aws" {
  region = "eu-north-1"
  profile = "default"
}

module "lambda" {
  source = "../"
  name = "hello_world"
  env = "test"
  s3_bucket = "grasplambda"
  s3_key = "test/hello_world.zip"
  handler = "hello_world.lambda_handler"
  iam_policy_arn = ["arn:aws:iam::aws:policy/AmazonS3FullAccess"]
}