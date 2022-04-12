variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "my_ip_with_cidr" {
  type = string
}

variable "bucket" {
  type    = string
  default = "9977712345678909888"
}

variable "instance_type" {
  type = string
}

variable "server_name" {
  type = string
}

variable "workspace_iam_roles" {
  default = {
    staging    = "arn:aws:iam::STAGING_ACCOUNT_ID:role/staging-role"
    production = "arn:aws:iam::PRODUCTION_ACCOUNT_ID:role/production-role"
  }
}