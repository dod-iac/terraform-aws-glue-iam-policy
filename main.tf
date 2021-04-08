/**
 * ## Usage
 *
 * Creates an IAM Policy for use with Glue that can read from any bucket and use any KMS key.
 *
 * ```hcl
 * module "glue_iam_policy" {
 *   source = "dod-iac/glue-iam-policy/aws"
 *
 *   name = "glue-iam-policy"
 *   buckets = ["*"]
 *   keys = ["*"]
 *   tags = {
 *     Automation  = "Terraform"
 *   }
 * }
 * ```
 *
 * Creates an IAM Policy for use with Glue that can read from a specific bucket and use any KMS key.
 *
 * ```hcl
 *
 * module "glue_iam_policy" {
 *   source = "dod-iac/glue-iam-policy/aws"
 *
 *   name = format("app-%s-glue-%s", var.application, var.environment)
 *   buckets = [aws_s3_bucket.main.arn]
 *   keys = ["*"]
 *   tags = {
 *     Application = var.application
 *     environment = var.environment
 *     Automation  = "Terraform"
 *   }
 * }
 * ```
 *
 * ## Terraform Version
 *
 * Terraform 0.13. Pin module version to ~> 1.0.0 . Submit pull-requests to master branch.
 *
 * Terraform 0.11 and 0.12 are not supported.
 *
 * ## License
 *
 * This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.
 */

data "aws_iam_policy_document" "main" {

  statement {
    sid = "ListBucket"
    actions = [
      "s3:GetBucketLocation",
      "s3:GetBucketRequestPayment",
      "s3:GetEncryptionConfiguration",
      "s3:ListBucket",
    ]
    effect    = length(var.buckets) > 0 ? "Allow" : "Deny"
    resources = length(var.buckets) > 0 ? var.buckets : ["*"]
  }

  statement {
    sid = "GetObject"
    actions = [
      "s3:GetObject",
    ]
    effect    = length(var.buckets) > 0 ? "Allow" : "Deny"
    resources = length(var.buckets) > 0 ? formatlist("%s/*", var.buckets) : ["*"]
  }

  statement {
    sid = "Decrypt"
    actions = [
      "kms:Decrypt",
    ]
    effect    = length(var.keys) > 0 ? "Allow" : "Deny"
    resources = length(var.keys) > 0 ? var.keys : ["*"]
  }

  statement {
    sid = "GetTable"
    actions = [
      "glue:*",
    ]
    effect    = length(var.databases) > 0 ? "Allow" : "Deny"
    resources = length(var.databases) > 0 ? var.databases : ["*"]
  }

}

resource "aws_iam_policy" "main" {
  name        = length(var.name) > 0 ? var.name : format("%s-policy", var.name)
  description = length(var.description) > 0 ? var.description : format("The policy for %s.", var.name)
  policy      = data.aws_iam_policy_document.main.json
}

