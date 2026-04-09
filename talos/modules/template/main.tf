resource "proxmox_virtual_environment_vm" "talos_template" {
  name      = var.name
  node_name = var.node_name
  stop_on_destroy = true
  tags = var.tags
  vm_id = var.vm_id
  description = var.description

  template = true
  started  = false

  agent {
    enabled = true
  }

  cpu {
    cores = var.cores
    type = var.type
  }

  memory {
    dedicated = var.memory
  }

  disk {
    datastore_id = var.datastore_id
    file_id      = proxmox_virtual_environment_download_file.talos_image.id
    interface    = var.interface
    size         = var.size
  }

  initialization {
    dns {
      servers = var.dns_servers
    }
    ip_config {
      ipv4 {
        address = var.ip_address
        gateway = var.default_gateway
      }
    }

  }

  network_device {
    bridge = var.network_bridge
    firewall = true
    model = var.network_model
  }

}

resource "proxmox_virtual_environment_download_file" "talos_image" {
  content_type = var.content_type
  datastore_id = var.datastore_id
  node_name    = var.node_name

  url = var.image_url
}
