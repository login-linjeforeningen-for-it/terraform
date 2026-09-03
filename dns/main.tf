resource "ovh_domain_zone_record" "apex_a" {
  for_each  = toset(local.managed_domains)
  zone      = each.value
  subdomain = ""
  fieldtype = "A"
  ttl       = var.ttl
  target    = var.onprem_ip
}

# ---------------- login.no service records ----------------

resource "ovh_domain_zone_record" "www_cname" {
  zone      = var.login
  subdomain = "www"
  fieldtype = "CNAME"
  ttl       = var.ttl
  target    = "login.no."
}

resource "ovh_domain_zone_record" "login_wildcard_a" {
  zone      = var.login
  subdomain = "*"
  fieldtype = "A"
  ttl       = var.ttl
  target    = var.onprem_ip
}

resource "ovh_domain_zone_record" "vaultwarden_a" {
  zone      = var.login
  subdomain = "vault"
  fieldtype = "A"
  ttl       = var.ttl
  target    = var.offprem_ip
}

resource "ovh_domain_zone_record" "zammad_a" {
  zone      = var.login
  subdomain = "zammad"
  fieldtype = "A"
  ttl       = var.ttl
  target    = var.offprem_ip
}

resource "ovh_domain_zone_record" "offprem_a" {
  zone      = var.login
  subdomain = "offprem"
  fieldtype = "A"
  ttl       = var.ttl
  target    = var.offprem_ip
}

resource "ovh_domain_zone_record" "authentik_a" {
  zone      = var.login
  subdomain = "authentik"
  fieldtype = "A"
  ttl       = var.ttl
  target    = var.offprem_ip
}

resource "ovh_domain_zone_record" "forms_a" {
  zone      = var.login
  subdomain = "forms"
  fieldtype = "A"
  ttl       = var.ttl
  target    = var.onprem_ip
}
