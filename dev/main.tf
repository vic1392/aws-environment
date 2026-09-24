terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Get subnets belonging to default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# S3 module
module "s3" {
  "git::https://github.com/vic1392/terraform-aws-infrastructure.git//modules/s3?ref=main"

  bucket_name = var.bucket_name
  environment = "dev"
}

# EC2 module
module "ec2" {
  source = "git::https://github.com/vic1392/terraform-aws-infrastructure.git//modules/ec2?ref=main"

  ami_id        = var.ami_id
  instance_type = var.instance_type
  subnet_id     = data.aws_subnets.default.ids[0]

  instance_name = "dev-ec2"

  s3_bucket_arn = module.s3.bucket_arn
}
