
data "aws_vpc" "main" {
  id = var.vpc_id
}

data "aws_availability_zones" "all" {}

data "aws_subnets" "subnet_ids" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.main.id]
  }

}

resource "aws_security_group" "sg_my_server" {
  name        = "sg_my_server"
  description = "My server Security group"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
  }
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.my_ip_with_cidr]
    ipv6_cidr_blocks = []
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}


data "template_file" "user_data" {
  template = file("${abspath(path.module)}/userdata.yaml")
}

resource "tls_private_key" "pk"{
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = tls_private_key.pk.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.pk.private_key_pem}' > ./terraform.pem"
  }
}

data "aws_ami" "ubuntu-east" {
  most_recent = true
  owners      = ["amazon"] #Amazon
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.20210813.1-x86_64-gp2*"]
  }

}

resource "aws_instance" "my_server" {
  ami                         = data.aws_ami.ubuntu-east.id
  instance_type               = var.instance_type
  subnet_id                   = flatten(data.aws_subnets.subnet_ids.ids)[0]
  associate_public_ip_address = true
  user_data              = data.template_file.user_data.rendered
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.sg_my_server.id]

  tags = {
    "Name" = var.server_name
  }
}
