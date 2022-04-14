provider "aws" {
  profile = "default"
  region = "us-east-2"
}

data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../project1/terraform.tfstate"
  }
}

module "apache" {
  source          = "monicalimachi/apache-example/aws"
  version         = "1.0.5"
  vpc_id          = data.terraform_remote_state.vpc.outputs.vpc_id
  my_ip_with_cidr = var.my_ip_with_cidr
  instance_type   = var.instance_type
  server_name     = var.server_name
}

output "public_ip" {
  value = module.apache.public_ip
}
