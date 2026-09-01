resource "ovh_domain_zone_record" "ctf_a" {
  zone      = var.login
  subdomain = "ctf"
  fieldtype = "A"
  ttl       = local.ttl_low
  target    = "129.241.150.18"
}

resource "ovh_domain_zone_record" "practice_ctf_a" {
  zone      = var.login
  subdomain = "practice.ctf"
  fieldtype = "A"
  ttl       = local.ttl_low
  target    = "129.241.150.215"
}

resource "ovh_domain_zone_record" "rebus_ctf_a" {
  zone      = var.login
  subdomain = "rebus"
  fieldtype = "A"
  ttl       = local.ttl_low
  target    = "129.241.150.118"
}
