terraform {

}

provider "aws" {
  region = "us-east-1"
}

module "apache" {
  source = ".//terraform-aws-apache-example"
  vpc_id = "vpc-004e5430015965c54"
  my_ip_with_cidr = "186.121.217.96/32"
  instance_type = "t2.micro"
  server_name = "Apache Server example"
  subnet_id = "subnet-08b95198d29acb21c"
}

output "public_ip" {
  value = module.apache.public_ip
}

