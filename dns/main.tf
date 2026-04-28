resource "digitalocean_record" "cdn_cname" {
  domain = var.login
  type   = "CNAME"
  name   = "cdn"
  value  = "beehive.ams3.cdn.digitaloceanspaces.com."
}

resource "digitalocean_record" "google_verify_forms" {
  domain = var.login
  type   = "TXT"
  name   = "forms"
  value  = "google-site-verification=ryrYCeqvEF5EDnpjioRq1DIyY6PByK-LbtkFwcI7m-c"
}

resource "digitalocean_record" "login_apex_a" {
  domain = var.login
  type   = "A"
  name   = "@"
  ttl    = 300
  value  = "128.39.142.138"
}

resource "digitalocean_record" "login_wildcard_a" {
  domain = var.login
  type   = "A"
  name   = "*"
  ttl    = 300
  value  = "128.39.142.138"
}

resource "digitalocean_record" "logout_a" {
  domain = var.logout
  type   = "A"
  name   = "@"
  ttl    = 300
  value  = "128.39.142.138"
}

resource "digitalocean_record" "vaultwarden_a" {
  domain = var.login
  type   = "A"
  name   = "vault"
  ttl    = 300
  value  = "57.129.124.84"
}

resource "digitalocean_record" "zammad_a" {
  domain = var.login
  type   = "A"
  name   = "zammad"
  ttl    = 300
  value  = "57.129.124.84"
}

resource "digitalocean_record" "offprem_record" {
  domain = var.login
  type   = "A"
  name   = "offprem"
  ttl    = 300
  value  = "57.129.124.84"
}