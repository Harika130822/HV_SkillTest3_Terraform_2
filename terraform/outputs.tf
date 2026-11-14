output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.nginx.public_ip
}

output "website_url" {
  description = "URL of the Terraform-managed Nginx welcome page"
  value       = "http://${aws_instance.nginx.public_ip}"
}