terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  description = "AWS deployment Region"
  type        = string
  sensitive   = false
}
variable "aws_access_key" {
  description = "AWS Ops User access key"
  type        = string
  sensitive   = true
}
variable "aws_secret" {
  description = "AWS Ops User secret key"
  type        = string
  sensitive   = true
}

variable "aws_account_num" {
  description = "AWS account number"
  type        = string
  sensitive   = true
}
