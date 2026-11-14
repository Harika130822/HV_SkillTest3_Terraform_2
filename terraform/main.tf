resource "aws_security_group" "nginx" {
  name        = "terraform-nginx-sg"
  description = "Allow HTTP and SSH access to the Terraform-managed Nginx server"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "terraform-nginx-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.nginx.id
  description       = "Allow inbound HTTP"
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.nginx.id
  description       = "Allow inbound SSH from the configured CIDR"
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = var.ssh_cidr
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.nginx.id
  description       = "Allow outbound traffic for package installation and updates"
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_instance" "nginx" {
  ami                         = data.aws_ami.ubuntu_2004.id
  instance_type               = "t3.micro"
  subnet_id                   = data.aws_subnets.default.ids[0]
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.nginx.id]
  user_data                   = file("${path.module}/user_data.sh.tpl")

  tags = {
    Name = "terraform-nginx-server"
  }
}
