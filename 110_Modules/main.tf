terraform {

}

provider "aws" {
  region = "us-east-2"
}

module "apache" {
  source = ".//terraform-aws-apache-example"
  vpc_id = "VPC_ID"
  my_ip_with_cidr = "YOUR_IP/32"
  instance_type = "t2.micro"
  server_name = "Apache Server example"
}

output "public_ip" {
  value = module.apache.public_ip
}

