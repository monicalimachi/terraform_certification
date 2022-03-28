terraform {
/*   cloud {
    organization = "los-patitos"
    workspaces {
      name = "provisioners"
    }
  } */

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.6.0" #version = "~> 4.6.0" Bug in latst version
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_vpc" "main" {
  id = "vpc-004e5430015965c54"
}

resource "aws_subnet" "main_subnet" {
  vpc_id     = data.aws_vpc.main.id
  cidr_block = cidrsubnet(data.aws_vpc.main.cidr_block, 4, 1)
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
    cidr_blocks      = ["186.121.217.96/32"]
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
  template = file("./userdata.yaml")
}

resource "tls_private_key" "pk"{
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  #public_key = "file(terraform.pub)"
  public_key = tls_private_key.pk.public_key_openssh
  provisioner "local-exec" {
    command = "echo '${tls_private_key.pk.private_key_pem}' > ./terraform.pem"
  }
}

resource "aws_instance" "my_server" {
  ami                    = "ami-087c17d1fe0178315"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.sg_my_server.id]
  user_data              = data.template_file.user_data.rendered
  subnet_id              = aws_subnet.main_subnet.id
  associate_public_ip_address = true

 # A file contains all commands, only one can be call 
/*   provisioner "local-exec" {
    command = "echo ${self.private_ip} >> files/private_ips.txt"
  } */

# Multiple inline can be made
/*   provisioner "remote-exec"{
    inline = [
      "echo ${self.private_ip} >> /home/ec2-user/private_ips.txt"
    ]
    #Need connection
    connection {
      type="ssh"
      user="ec2-user"
      host="${self.public_ip}"
      private_key = file("terraform.pem")
    } */

# 
  provisioner "file"{
    content = "ami used: ${self.ami}"
    destination = "/home/ec2-user/barmony.txt"
    
    #Need connection
    connection {
      type="ssh"
      user="ec2-user"
      host="${self.public_ip}"
      private_key = file("terraform.pem")
    }

  }

  tags = {
    Name = "MyServer"
  }
}

output "public_ip" {
  value = aws_instance.my_server.public_ip
}