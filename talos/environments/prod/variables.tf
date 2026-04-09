variable "endpoint" {
  type = string
}

variable "token" {
  type = string
  sensitive = true
}

variable "vms" {
  type = map(object({
    name            = string
    node_name       = string
    vm_id           = number
    tags            = list(string)
    clone_vm_id     = number
    guest_agent     = bool
    memory          = number
    ip_address      = string
    default_gateway = string
  }))
  default = {}
}
