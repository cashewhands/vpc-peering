terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    random = ">= 2"
  }

  cloud {
    organization = "Cashewhands"
    workspaces {
      tags = [
        "vpc-peering",
      ]
    }
  }
}