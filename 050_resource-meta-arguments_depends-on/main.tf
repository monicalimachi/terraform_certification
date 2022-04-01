terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.6.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

data "aws_subnet" "subnet-01" {
  id = "subnet-08b95198d29acb21c"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "123456789-depends-on"
  depends_on = [
    aws_instance.myserver
  ]
  tags = {
    Name        = "My bucket"
    Environment = "Test"
  }
}

resource "aws_instance" "myserver" {
  ami           = "ami-087c17d1fe0178315"
  instance_type = "t2.micro"
  subnet_id = data.aws_subnet.subnet-01.id
  associate_public_ip_address = true

  tags = {
    "Name" = "MyServer"
  }
}

output "public_ip" {
  value = aws_instance.myserver.public_ip
}