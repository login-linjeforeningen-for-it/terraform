

// Register all domains in Digitalocean
resource "digitalocean_domain" "all_domains" {
  for_each = toset(module.domeneshop.domain_names)
  name     = each.value

}

// Create A records for each domain
// All top level domains point to the onprem proxy
resource "digitalocean_record" "a_login_records" {
  for_each = digitalocean_domain.all_domains

  domain = each.value.name
  name   = "@"
  type   = "A"
  value  = var.onprem_ip

}

resource "digitalocean_record" "cdn_cname" {
  domain = var.login
  type   = "CNAME"
  name   = "cdn"
  value  = "beehive.ams3.cdn.digitaloceanspaces.com."
}

resource "digitalocean_record" "login_wildcard_a" {
  domain = var.login
  type   = "A"
  name   = "*"
  ttl    = 300
  value  = var.onprem_ip
}

resource "digitalocean_record" "vaultwarden_a" {
  domain = var.login
  type   = "A"
  name   = "vault"
  ttl    = 300
  value  = var.offprem_ip
}

resource "digitalocean_record" "zammad_a" {
  domain = var.login
  type   = "A"
  name   = "zammad"
  ttl    = 300
  value  = var.offprem_ip
}

resource "digitalocean_record" "offprem_record" {
  domain = var.login
  type   = "A"
  name   = "offprem"
  ttl    = 300
  value  = var.offprem_ip
}

resource "digitalocean_record" "linux_install_party_record" {
  domain = var.login
  type   = "A"
  name   = "linux"
  ttl    = 300
  value  = 128.39.142.60
}
