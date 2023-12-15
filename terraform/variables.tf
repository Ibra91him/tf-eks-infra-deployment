variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "clusterName" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "demo-eks-tf"
}

variable "vpcName" {
  description = "Name of the VPC"
  type        = string
  default     = "demo-eks-vpc-tf-02"
}
