variable "name" {
  type        = string
  default     = null
  description = "Bucket name."
}

variable "acl" {
  type        = string
  default     = "private"
  description = "The [canned ACL](https://docs.aws.amazon.com/AmazonS3/latest/dev/acl-overview.html#canned-acl) to apply. We recommend `private` to avoid exposing sensitive information. Conflicts with `grants`."
}

variable "force_destroy" {
  type        = bool
  default     = false
  description = "A boolean string that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable"
}

variable "sse_algorithm" {
  type        = string
  default     = "AES256"
  description = "The server-side encryption algorithm to use. Valid values are `AES256` and `aws:kms`"
}

variable "kms_master_key_arn" {
  type        = string
  default     = ""
  description = "The AWS KMS master key ARN used for the `SSE-KMS` encryption. This can only be used when you set the value of `sse_algorithm` as `aws:kms`. The default aws/s3 AWS KMS master key is used if this element is absent while the `sse_algorithm` is `aws:kms`"
}

variable "lifecycle_rules" {
  type = list(object({
    prefix  = string
    enabled = bool
    tags    = map(string)

    enable_glacier_transition        = bool
    enable_deeparchive_transition    = bool
    enable_standard_ia_transition    = bool
    enable_current_object_expiration = bool

    abort_incomplete_multipart_upload_days         = number
    noncurrent_version_glacier_transition_days     = number
    noncurrent_version_deeparchive_transition_days = number
    noncurrent_version_expiration_days             = number

    standard_transition_days    = number
    glacier_transition_days     = number
    deeparchive_transition_days = number
    expiration_days             = number
  }))
  default = [{
    enabled = true 
    prefix  = ""
    tags    = {}

    enable_glacier_transition        = true
    enable_deeparchive_transition    = false
    enable_standard_ia_transition    = false
    enable_current_object_expiration = true

    abort_incomplete_multipart_upload_days         = 90
    noncurrent_version_glacier_transition_days     = 30
    noncurrent_version_deeparchive_transition_days = 60
    noncurrent_version_expiration_days             = 90

    standard_transition_days    = 30
    glacier_transition_days     = 60
    deeparchive_transition_days = 90
    expiration_days             = 90
  }]
  description = "A list of lifecycle rules"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags"
}

variable "versioning_enabled" {
  type        = bool
  default     = true
  description = "A state of versioning. Versioning is a means of keeping multiple variants of an object in the same bucket"
}