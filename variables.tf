variable "buckets" {
  type        = list(string)
  description = "The ARNs of the AWS S3 buckets the policy is allowed to read from.  Use [\"*\"] to allow all buckets."
  default     = []
}

variable "description" {
  type        = string
  description = "The description of the AWS IAM policy."
  default     = ""
}

variable "keys" {
  type        = list(string)
  description = "The ARNs of the AWS KMS keys the policy is allowed to use to decrypt files.  Use [\"*\"] to allow all keys."
  default     = []
}

variable "name" {
  type        = string
  description = "The name of the AWS IAM policy."
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to the AWS IAM policy."
  default     = {}
}
