output "instance_ip" {
  value = module.web-server.ec2_public_ip
}

output "public_subnet_id" {
  description = "The ID of the subnet"
  value       = module.network-us.public_subnet_id
}

/* output "public_subnet_cidr_block" {
  description = "The CIDR Block of the public subnet"
  value       = module.us-east.public_subnet_cidr_block
} */