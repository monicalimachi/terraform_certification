terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.6.0"
    }
  }
}
variable "instance_type" {
  type = string
  description = "The size of the instance"
  sensitive = false # Hide the info in the plan not in the tfstate file
  validation {
    condition = can(regex("^t2.",var.instance_type))
    error_message = "The instance must be a t2 type EC2 instance."
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

data "aws_subnet" "subnet-01" {
  id = "subnet-08b95198d29acb21c"
}

resource "aws_instance" "name" {
  ami           = "ami-087c17d1fe0178315"
  instance_type = var.instance_type
  subnet_id = data.aws_subnet.subnet-01.id
  associate_public_ip_address = true

  tags = {
    "Name" = "MyServer"
  }
}

output "public_ip" {
  value = aws_instance.name.public_ip
  sensitive = true
}