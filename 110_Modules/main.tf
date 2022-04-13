terraform {

}

provider "aws" {
  region = "us-east-2"
}

module "apache" {
  source = ".//terraform-aws-apache-example"
  vpc_id = "vpc-015de37ecd18e94f2"
  my_ip_with_cidr = "186.121.217.96/32"
  instance_type = "t2.micro"
  server_name = "Apache Server example"
}

output "public_ip" {
  value = module.apache.public_ip
}

