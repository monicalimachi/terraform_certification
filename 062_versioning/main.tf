# Different options to use versions on required providers or terrafor versions, it can also use on Terraform Cloud
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.8.0"
    }
  }
  required_version = "~>1.1.7" # ">=1.1.7""<1.2.0"

}