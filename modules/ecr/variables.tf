variable "prefix" {
  description = "Prefix for images."
  type = string
  default = "Aider"
}

variable "image_names" {
  description = "Name of the image."
  type = list(string)
}

variable "stage" {
  description = "Stage, e.g. 'prod', 'staging', 'dev', OR 'source', 'build', 'test', 'deploy', 'release'"
  type = string
  default = null
}

variable "tags" {
  description = "Tags of ECR."
  type = map
  default = {}
}
