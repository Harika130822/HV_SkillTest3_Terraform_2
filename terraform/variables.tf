variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "ssh_cidr" {
  description = "IPv4 CIDR allowed to connect over SSH; restrict this to your public IP using /32."
  type        = string
  default     = "0.0.0.0/0"
}
