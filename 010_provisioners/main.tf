terraform {
  cloud {
    organization = "los-patitos"
    workspaces {
      name = "provisioners"
    }
  }

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
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDvWvn1X4bky1Qm5fKShhQZnlzTKRX9Rqw0yxVZx1MK3x+VSCmEzqFcEGaUd8GdZpn7mURCq0MeuWZJlvlyXV6mwfBbyiyO4GfadrYujycTH059N4sqPgYiTlnAp3i8F359q5gtnJvYDz6TXP2hpoz/e2VHqtTqfsWnDGEu/q5FpJvEAlREJQyc8rKzU85U4bpoOnorv2+1y+muMUX6SNw8OyLRIeOE6DiAlR+z6wAFCWCBa3tCL/djP1d9hqdENvE2FlOKCLcce5KVqvSm08Qs/oEFvQmRztj+rGXsDjUDBJ+tWjnk9leJ882o+FFe3p3D7EBjRTh6cD4gdHXMMg50jX4FRw5pCg3bdfA4wc1sex9pBZ3Uj+cYoE29YhsmuaGvM+nbkhzX+jpqHNprsdgRq00oQU5VEHtATUFK1iIGHqxIDBPNKRUI82Pt9A3xRWJvQKxYKboTH24tr6bjneFCe+hoQ/kTiSbhJMbP1PLSWnoMApXmF5ifsb6k7idStas= mony@mony"
}

resource "aws_instance" "my_server" {
  ami                    = "ami-087c17d1fe0178315"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.sg_my_server.id]
  user_data              = data.template_file.user_data.rendered
  subnet_id              = aws_subnet.main_subnet.id
  associate_public_ip_address = true
  tags = {
    Name = "MyServer"
  }
}

output "public_ip" {
  value = aws_instance.my_server.public_ip
}