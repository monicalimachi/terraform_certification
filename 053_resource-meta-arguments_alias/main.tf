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
  alias = "east"
}

provider "aws" {
  profile = "default"
  region  = "us-west-1"
  alias = "west"
}

data "aws_subnet" "subnet-01-east" {
  id = "subnet-08b95198d29acb21c"
  provider = aws.east
}

/* data "aws_subnet" "subnet-01-west" {
  id = "subnet-059a96cdfead1ca55"
} */

data "aws_ami" "ubuntu" {
  #executable_users = ["self"]
  most_recent      = true
  owners           = ["amazon"] #Amazon

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.20210813.1-x86_64*"]
  }

}

resource "aws_instance" "my_west_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  #subnet_id = data.aws_subnet.subnet-01.id
  associate_public_ip_address = true
  provider = aws.west

  tags = {
    "Name" = "My West Server"
  }
}

resource "aws_instance" "my_east_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = data.aws_subnet.subnet-01-east.id
  associate_public_ip_address = true
  provider = aws.east

  tags = {
    "Name" = "My East Server"
  }
}

output "public_ip_east" {
  value = aws_instance.my_east_server.public_ip
}
output "public_ip_west" {
  value = aws_instance.my_west_server.public_ip
}
