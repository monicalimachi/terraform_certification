terraform {
  cloud {
    organization = "los-patitos"

    workspaces {
      name = "terraform-getting-started"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.6.0" #version = "~> 4.6.0" Bug in latst version
    }
  }
}

locals {
  project_name = "Monica-123"
}