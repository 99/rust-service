variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default     = "addbucket"

}

variable "role_name" {
  description = "The name of the IAM role"
  type        = string
  default     = "EKS_S3_Write_Access"
}

variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default     = "eks-meetup-demo"
}
