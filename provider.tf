terraform {
  required_providers {
    # https://registry.terraform.io/providers/orange-cloudavenue/cloudavenue/latest/docs
    cloudavenue = {
      source  = "orange-cloudavenue/cloudavenue"
      version = ">=0.32.0"
    }
  }
  required_version = ">=1.0"
}
