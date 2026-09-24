variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "bucket_name" {
  type = string
}
