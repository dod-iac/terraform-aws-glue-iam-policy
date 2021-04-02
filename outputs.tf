# Outputs
output "arn" {
  description = "The Amazon Resource Name (ARN) of the AWS IAM Policy."
  value       = aws_iam_policy.main.arn
}

output "name" {
  description = "The name of the AWS IAM Policy."
  value       = aws_iam_policy.main.name
}
