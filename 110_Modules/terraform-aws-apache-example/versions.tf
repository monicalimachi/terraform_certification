terraform {
/*   cloud {
    organization = "los-patitos"
    workspaces {
      name = "provisioners"
    }
  } */

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=4.6.0" #version = "~> 4.6.0" Bug in latst version
    }
  }
}