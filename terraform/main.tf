provider "aws" {
  region = "us-east-1"
}

data "aws_s3_bucket" "this" {
  bucket = var.bucket_name
}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

resource "aws_iam_policy" "s3_write_policy" {
  name        = "S3WritePolicy"
  description = "Policy to allow writing to the S3 bucket"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::${data.aws_s3_bucket.this.bucket}",
          "arn:aws:s3:::${data.aws_s3_bucket.this.bucket}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role" "eks_role" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.eks_role.name
  policy_arn = aws_iam_policy.s3_write_policy.arn
}
