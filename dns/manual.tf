resource "ovh_domain_zone_record" "www_cname" {
  zone      = var.login
  subdomain = "www"
  fieldtype = "CNAME"
  ttl       = local.ttl_low
  target    = "login.no."
}

resource "ovh_domain_zone_record" "authentik_a" {
  zone      = var.login
  subdomain = "authentik"
  fieldtype = "A"
  ttl       = local.ttl_low
  target    = var.offprem_ip
}

resource "ovh_domain_zone_record" "forms_a" {
  zone      = var.login
  subdomain = "forms"
  fieldtype = "A"
  ttl       = local.ttl_low
  target    = var.onprem_ip
}
