output "eks_cluster_endpoint" {
  value       = data.aws_eks_cluster.cluster.endpoint
  description = "The endpoint for the EKS cluster"
}

output "bucket_name" {
  value       = data.aws_s3_bucket.this.bucket
  description = "The name of the S3 bucket"
}

output "cluster_name" {
  value       = data.aws_eks_cluster.cluster.name
  description = "The name of the EKS cluster"
}
