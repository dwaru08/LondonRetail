terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.63.0"
    }
  }
}

provider "aws" {
  region = var.region
  access_key ="AKIA4RFUVQTNWDXH7IH6"
  secret_key = "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"
}


