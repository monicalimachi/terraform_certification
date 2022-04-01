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

resource "aws_instance" "myserver" {
  ami           = "ami-087c17d1fe0178315"
  for_each = {
      nano = "t2.nano"
      micro = "t2.micro"
      small = "t2.small"
  }
  instance_type = each.value
  subnet_id = data.aws_subnet.subnet-01.id
  associate_public_ip_address = true

  tags = {
    "Name" = "MyServer-${each.key}"
  }
}

output "public_ip" {
  value = values(aws_instance.myserver)[*].public_ip
}
