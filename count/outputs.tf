output "user_arns" {
  value       = aws_iam_user.example[*].arn
  description = "The ARNs of the created IAM users"
}