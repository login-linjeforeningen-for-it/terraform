terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.86.0"
    }
  }
}

provider "proxmox" {
  endpoint  = var.endpoint
  api_token = var.token
  insecure = true
  ssh {
    agent    = false
    username = "root"
    private_key = file("~/.ssh/id_rsa")
  }
}