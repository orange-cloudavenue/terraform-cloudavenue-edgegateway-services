terraform {
  required_providers {
    cloudavenue = {
      source  = "orange-cloudavenue/cloudavenue"
      version = ">= 0.31.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}
