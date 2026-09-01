terraform {
  required_providers {
    ovh = {
      source  = "ovh/ovh"
      version = "~> 1.5"
    }
  }
  backend "s3" {
    region = "de"
    bucket = "tekkom-terraform"
    key    = "dns/terraform.tfstate"
    endpoints = {
      s3 = "https://s3.de.io.cloud.ovh.net/"
    }
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}

provider "ovh" {
  endpoint = "ovh-ca"
}
