terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }

  required_version = "~> 1.3"
}

provider "cloudflare" {
  api_token = var.cloudflare-config.api-token
}