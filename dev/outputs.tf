output "ec2_instance_id" {
  value = module.ec2.instance_id
}

output "ec2_private_ip" {
  value = module.ec2.private_ip
}

output "s3_bucket_name" {
  value = module.s3.bucket_name
}
