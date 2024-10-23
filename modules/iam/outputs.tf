output "lambda_iam_role" {
  description = "The IAM role for the Lambda function"
  value       = aws_iam_role.lambda_role.arn
}
