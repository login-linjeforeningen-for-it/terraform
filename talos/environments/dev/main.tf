module "template" {
  source = "../../modules/template"
}

module "clone" {
  source = "../../modules/clone"

  depends_on = [
    module.template
  ]

  for_each = var.vms

  name            = each.value.name
  node_name       = each.value.node_name
  vm_id           = each.value.vm_id
  tags            = each.value.tags
  clone_vm_id     = each.value.clone_vm_id
  guest_agent     = each.value.guest_agent
  memory          = each.value.memory
  ip_address      = each.value.ip_address
  default_gateway = each.value.default_gateway
}