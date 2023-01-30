output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.web_server.public_ip
}

output "ec2_public_ip" {
  value = aws_instance.web_server[*].public_ip
}


output "ec2_public_dns" {
  value = aws_instance.web_server[*].public_dns
}