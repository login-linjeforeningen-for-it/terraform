resource "proxmox_virtual_environment_vm" "talos" {
  name      = var.name
  node_name = var.node_name
  tags = var.tags
  vm_id = var.vm_id
  stop_on_destroy = true

  clone {
    vm_id = var.clone_vm_id
    full = true
  }

  agent {
    # NOTE: The agent is installed and enabled as part of the cloud-init configuration in the template VM, see cloud-config.tf
    # The working agent is *required* to retrieve the VM IP addresses.
    # If you are using a different cloud-init configuration, or a different clone source
    # that does not have the qemu-guest-agent installed, you may need to disable the `agent` below and remove the `vm_ipv4_address` output.
    # See https://registry.terraform.io/providers/bpg/proxmox/latest/docs/resources/virtual_environment_vm#qemu-guest-agent for more details.
    enabled = var.guest_agent
  }

  memory {
    dedicated = var.memory
  }

  initialization {
    ip_config {
      ipv4 {
        address = var.ip_address
        gateway = var.default_gateway
      }
    }
  }
}