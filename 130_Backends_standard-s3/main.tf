terraform {
  backend "s3" {
    bucket = "terraform-backend-mony-123456"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "force-unlock-terraform"
  }
}

provider "aws" {
  region = "us-east-1"
  #Multiple workspaces, use option assume_role to set role and workspace to use
/*   assume_role {
    role_arn = var.workspace_iam_roles[terraform.workspace]
  } */
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket
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
