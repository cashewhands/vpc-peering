output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.vpc.id
}


output "public_subnet_id" {
  description = "ID of the Public Subnet"
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "ID of the Private Subnet"
  value       = aws_subnet.private.id
}

/* output "public_subnet_cidr_block" {
  description = "CIDR Block of the Public Subnet"
  value       = aws_subnet.public.cidr_block
}

output "private_subnet_cidr_block" {
  description = "CIDR Block of the Private Subnet"
  value       = aws_subnet.private.cidr_block
} */