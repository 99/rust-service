output "role_arn" {
  description = "The ARN of the IAM role"
  value       = aws_iam_role.eks_role.arn
}


output "ecr_repository_url" {
  description = "The URL of the ECR repository"
  value       = aws_ecr_repository.rust_service.repository_url
}