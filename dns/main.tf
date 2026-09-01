resource "ovh_domain_zone_record" "apex_a" {
  for_each  = toset(local.managed_domains)
  zone      = each.value
  subdomain = ""
  fieldtype = "A"
  ttl       = local.zone_ttl[each.value]
  target    = var.onprem_ip
}

# ---------------- login.no service records ----------------

resource "ovh_domain_zone_record" "cdn_cname" {
  zone      = var.login
  subdomain = "cdn"
  fieldtype = "CNAME"
  ttl       = local.ttl_low
  target    = "beehive.ams3.cdn.digitaloceanspaces.com."
}

resource "ovh_domain_zone_record" "login_wildcard_a" {
  zone      = var.login
  subdomain = "*"
  fieldtype = "A"
  ttl       = local.ttl_low
  target    = var.onprem_ip
}

resource "ovh_domain_zone_record" "vaultwarden_a" {
  zone      = var.login
  subdomain = "vault"
  fieldtype = "A"
  ttl       = local.ttl_low
  target    = var.offprem_ip
}

resource "ovh_domain_zone_record" "zammad_a" {
  zone      = var.login
  subdomain = "zammad"
  fieldtype = "A"
  ttl       = local.ttl_low
  target    = var.offprem_ip
}

resource "ovh_domain_zone_record" "offprem_a" {
  zone      = var.login
  subdomain = "offprem"
  fieldtype = "A"
  ttl       = local.ttl_low
  target    = var.offprem_ip
}

# ---------------- Linux install party ----------------

resource "ovh_domain_zone_record" "linux_a" {
  zone      = var.login
  subdomain = "linux"
  fieldtype = "A"
  ttl       = local.ttl_low
  target    = var.offprem_ip
}

resource "ovh_domain_zone_record" "linux_ntnu_a" {
  zone      = var.login
  subdomain = "ntnu.linux"
  fieldtype = "A"
  ttl       = local.ttl_low
  target    = "128.39.142.60"
}

resource "ovh_domain_zone_record" "linux_ovhcloud_cname" {
  zone      = var.login
  subdomain = "ovhcloud.linux"
  fieldtype = "CNAME"
  ttl       = local.ttl_low
  target    = "tekkom-linux.s3.de.io.cloud.ovh.net."
}
