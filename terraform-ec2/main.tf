# Default VPC and subnets
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Latest Ubuntu 24.04 LTS AMI via Canonical SSM
# This stays current within the 24.x line without hardcoding an AMI ID.
data "aws_ssm_parameter" "ubuntu_24_04_ami" {
  name = "/aws/service/canonical/ubuntu/server/24.04/stable/current/amd64/hvm/ebs-gp3/ami-id"
}

resource "aws_key_pair" "ssh" {
  key_name   = var.key_pair_name
  public_key = file(pathexpand(var.ssh_public_key_path))
}

resource "aws_security_group" "ssh_only" {
  name        = var.security_group_name
  description = "Allow SSH from a single IP"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.security_group_name
  }
}

resource "aws_instance" "ubuntu" {
  ami                    = data.aws_ssm_parameter.ubuntu_24_04_ami.value
  instance_type          = var.instance_type
  subnet_id              = data.aws_subnets.default.ids[0]
  vpc_security_group_ids = [aws_security_group.ssh_only.id]
  key_name               = aws_key_pair.ssh.key_name
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              set -euo pipefail
              apt-get update -y
              apt-get install -y docker.io gh apache2 git
              systemctl enable --now docker
              systemctl enable --now apache2
              EOF

  tags = {
    Name = var.instance_name
  }
}
