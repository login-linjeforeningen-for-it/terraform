variable "virtual_environment_endpoint" {
  type        = string
  description = "The endpoint for the Proxmox Virtual Environment API (example: https://host:port)"
  default = ""
}

variable "virtual_environment_token" {
  type        = string
  description = "The token for the Proxmox Virtual Environment API"
  sensitive   = true
  default = ""
}

variable "name" {
  type = string
  description = "The name of the template"
  default = "talos-clone"
}

variable "node_name" {
  type        = string
  description = "The node name for the Proxmox Virtual Environment API"
  default     = "pve-nas"
}

variable "tags" {
  type = list(string)
  description = "Tags used for the template"
  default = [ "dev", "kubernetes", "terraform" ]
}

variable "vm_id" {
  type = number
  description = "The ID of the VM in Proxmox"
  default = 9991
}

variable "clone_vm_id" {
  type = number
  description = "The ID for the template to be cloned"
  default = 9990
}

variable "guest_agent" {
  type = bool
  description = "Enable the qemu guest agent"
  default = true
}

variable "memory" {
  type = number
  description = "How much memory the VM should have"
  default = 2048
}

variable "ip_address" {
  type = string
  description = "The IP address for the VM"
  default = "172.16.0.31/24"
}

variable "default_gateway" {
  type = string
  description = "The IP address of the gateway"
  default = "172.16.0.1"
}