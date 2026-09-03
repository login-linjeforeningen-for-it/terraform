locals {
  onprem_cnames = [
    "idrac1",
    "idrac2",
    "idrac3",
    "pve",
    "truenas",
    "pelican",
    "pfsense",
    "wings",
  ]
}

resource "ovh_domain_zone_record" "onprem_mgmt_a" {
  zone      = var.login
  subdomain = "onprem"
  fieldtype = "A"
  ttl       = var.ttl
  target    = var.onprem_mgmt_ip
}

resource "ovh_domain_zone_record" "onprem_cname_records" {
  for_each  = toset(local.onprem_cnames)
  zone      = var.login
  subdomain = each.value
  fieldtype = "CNAME"
  ttl       = var.ttl
  target    = "onprem.${var.login}."
}
