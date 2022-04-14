terraform {
  cloud {
    organization = "los-patitos"

    workspaces {
      name = "force_unlocking"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "apache" {
  source          = "monicalimachi/apache-example/aws"
  version         = "1.0.5"
  vpc_id          = var.vpc_id
  my_ip_with_cidr = var.my_ip_with_cidr
  instance_type   = var.instance_type
  server_name     = var.server_name
}

output "public_ip" {
  value = module.apache.public_ip
}