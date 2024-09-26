resource "aws_security_group" "server" {
  name        = "server_net_ue_reg"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.net_ue_reg.id

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "tag_server"
  }
}

resource "aws_instance" "web" {
  ami           = "ami-456871456"
  instance_type = var.server_type
  subnet_id     = aws_subnet.subnet_ue_1.id
  associate_public_ip_address = var.include_ipv4
  tags = {
    Name = "tag_web"
  }
}
