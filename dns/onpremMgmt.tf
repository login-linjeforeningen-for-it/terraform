locals {
  subDomains = [
    "idrac1",
    "idrac2",
    "idrac3",
    "pve",
    "truenas",
    "pelican",
    "pfsense"
  ]
}

resource "digitalocean_record" "onprem_mgmt_record" {
  domain = var.login
  name   = "onprem"
  type   = "A"
  value  = var.onprem_mgmt_ip
}

resource "digitalocean_record" "onprem_cname_records" {
  for_each = toset(local.subDomains)

  domain = var.login
  name   = each.value
  type   = "CNAME"
  value  = "onprem.${var.login}."
}