<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Usage

Creates an IAM Policy for use with Glue that can read from any bucket and use any KMS key.

```hcl
module "glue_iam_policy" {
  source = "dod-iac/glue-iam-policy/aws"

  name = "glue-iam-policy"
  buckets = ["*"]
  keys = ["*"]
  tags = {
    Automation  = "Terraform"
  }
}
```

Creates an IAM Policy for use with Glue that can read from a specific bucket and use any KMS key.

```hcl

module "glue_iam_policy" {
  source = "dod-iac/glue-iam-policy/aws"

  name = format("app-%s-glue-%s", var.application, var.environment)
  buckets = [aws_s3_bucket.main.arn]
  keys = ["*"]
  tags = {
    Application = var.application
    environment = var.environment
    Automation  = "Terraform"
  }
}
```

## Terraform Version

Terraform 0.13. Pin module version to ~> 1.0.0 . Submit pull-requests to master branch.

Terraform 0.11 and 0.12 are not supported.

## License

This project constitutes a work of the United States Government and is not subject to domestic copyright protection under 17 USC § 105.  However, because the project utilizes code licensed from contributors and other third parties, it therefore is licensed under the MIT License.  See LICENSE file for more information.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_document.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_buckets"></a> [buckets](#input\_buckets) | The ARNs of the AWS S3 buckets the policy is allowed to read from.  Use ["*"] to allow all buckets. | `list(string)` | `[]` | no |
| <a name="input_databases"></a> [databases](#input\_databases) | The ARNs of the AWS Glue Databases.  Use ["*"] to allow all databases. | `list(string)` | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the AWS IAM policy. | `string` | `""` | no |
| <a name="input_keys"></a> [keys](#input\_keys) | The ARNs of the AWS KMS keys the policy is allowed to use to decrypt files.  Use ["*"] to allow all keys. | `list(string)` | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the AWS IAM policy. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags applied to the AWS IAM policy. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The Amazon Resource Name (ARN) of the AWS IAM Policy. |
| <a name="output_name"></a> [name](#output\_name) | The name of the AWS IAM Policy. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
