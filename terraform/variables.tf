variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-1"
}

variable "clusterName" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "vprofile-eks"
}

variable "vpcName" {
  description = "Name of the VPC"
  type        = string
  default     = "demo-eks-vpc-tf"
}

