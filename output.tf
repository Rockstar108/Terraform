output "ec2-public-ip" {
  value = module.myapp-instance.ec2-instance-details.public_ip
}
