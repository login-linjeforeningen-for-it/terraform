variable "endpoint" {
  type        = string
  description = "The endpoint for the Proxmox Virtual Environment API (example: https://host:port)"
  default = ""
}

variable "token" {
  type        = string
  description = "The token for the Proxmox Virtual Environment API"
  sensitive   = true
  default = ""
}

variable "name" {
  type = string
  description = "The name of the template"
  default = "talos-template"
}

variable "node_name" {
  type        = string
  description = "The node name for the Proxmox Virtual Environment API"
  default     = "pve-nas"
}

variable "tags" {
  type = list(string)
  description = "Tags used for the template"
  default = [ "template" ]
}

variable "vm_id" {
  type = number
  description = "The ID of the template in Proxmox"
  default = 9990
}

variable "description" {
  type = string
  description = "Description for the template in Proxmox"
  default = "Managed by Terraform"
}

variable "cores" {
  type = number
  description = "How many cores the VM should have"
  default = 2
}

variable "type" {
  type = string
  description = "What type should the CPU should be"
  default = "x86-64-v2-AES"
}

variable "memory" {
  type = number
  description = "How much memory the VM should have"
  default = 2048
}

variable "datastore_id" {
  type        = string
  description = "Datastore for VM disks"
  default     = "sdb"
}

variable "interface" {
  type = string
  description = "The disk interface used"
  default = "scsi0"
}

variable "size" {
  type = number
  description = "The size of the disk"
  default = 20
}

variable "dns_servers" {
  type = list(string)
  description = "The IP addresses for DNS servers"
  default = [ "172.16.0.1" ]
}

variable "ip_address" {
  type = string
  description = "The IP address for the VM"
  default = "172.16.0.30/24"
}

variable "default_gateway" {
  type = string
  description = "The IP address of the gateway"
  default = "172.16.0.1"
}

variable "network_bridge" {
  type = string
  description = "The network bridge used in Proxmox"
  default = "vmbr0"
}

variable "network_model" {
  type = string
  description = "The virtual network interface used"
  default = "virtio"
}

variable "content_type" {
  type = string
  description = "The filetype of the image used"
  default = "iso"
}

variable "image_url" {
  type = string
  description = "The download URL for the image"
  default = "https://factory.talos.dev/image/ce4c980550dd2ab1b17bbf2b08801c7eb59418eafe8f279833297925d67c7515/v1.11.5/nocloud-amd64.iso"
}