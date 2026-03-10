locals {
  k8s_domains = [
    "login.no",
    "logntnu.no",
    "logout.no",
  ]
  non_k8s_domains = [
    for d in module.domains.domain_names : d if !contains(local.k8s_domains, d)
  ]
}

module "domains" {
  source = "../modules/domeneshop"
}

resource "digitalocean_domain" "domains" {
  for_each = toset(local.non_k8s_domains)
  name     = each.key
}

resource "digitalocean_record" "a_record" {
  for_each = toset(local.non_k8s_domains)
  domain   = each.key
  type     = "A"
  name     = "@"
  value    = var.lb_external_ip
}

# resource "digitalocean_record" "login_mx1" {
#   domain   = var.login
#   type     = "MX"
#   name     = "@"
#   value    = "mx1.emailsrvr.com."
#   priority = 10
# }

# resource "digitalocean_record" "login_mx2" {
#   domain   = var.login
#   type     = "MX"
#   name     = "@"
#   value    = "mx2.emailsrvr.com."
#   priority = 20
# }

# Creates a TXT record for DKIM (DomainKeys Identified Mail) email authentication.
# DKIM helps verify that emails sent from this domain are legitimate and haven't been
# tampered with during transit. This specific record contains the public RSA key that
# receiving mail servers use to validate the DKIM signature in email headers.
# The selector "20221010-xpztq0z9" is used to identify this particular DKIM key.
# resource "digitalocean_record" "login_txt_dkim" {
#   domain = var.login
#   type   = "TXT"
#   name   = "20221010-xpztq0z9._domainkey"
#   value  = "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDx+Vek3w/EJdI45vWGjjYKdlLxkv1tl1T/6pR2pKyC//6SQDUTQJv7zpoFii8Ai4jLfW88du9MegqorSwY8/bTEbylhbyHQ/7xZcQntTZ43lL4EJc7pk7bw+FZIxBziKLNhejJhx+SlhpOTQkvyc/E+DK/pB14YhbMx2XiZjjD2QIDAQAB"
# }

# Creates a TXT record for SPF (Sender Policy Framework) configuration on the login domain.
# This record specifies which mail servers are permitted to send email on behalf of the domain.
# The SPF record includes emailsrvr.com as an authorized sender and uses a soft fail (~all) 
# policy for all other sources, which marks emails from unauthorized sources as potentially spam
# but doesn't reject them outright.
# resource "digitalocean_record" "login_txt_spf" {
#   domain = var.login
#   type   = "TXT"
#   name   = "@"
#   value  = "v=spf1 include:emailsrvr.com ~all"
# }

# Creates a DMARC (Domain-based Message Authentication, Reporting & Conformance) TXT record
# for the login domain in DigitalOcean DNS.
#
# This record instructs receiving mail servers to:
# - Apply a quarantine policy (p=quarantine) to emails that fail DMARC authentication
# - Send aggregate reports (rua) about email authentication results to tekkom@login.no
#
# DMARC helps protect the domain from email spoofing and phishing attacks by verifying
# that emails claiming to be from this domain actually originate from authorized sources.
# resource "digitalocean_record" "login_txt_dmarc" {
#   domain = var.login
#   type   = "TXT"
#   name   = "_dmarc"
#   value  = "v=DMARC1; p=quarantine; rua=mailto:tekkom@login.no"
# }

# Creates a CNAME DNS record for the CDN subdomain pointing to DigitalOcean Spaces CDN.
# This record routes traffic from cdn.<domain> to the DigitalOcean Spaces CDN endpoint
# in the AMS3 (Amsterdam 3) region for the 'beehive' Space, enabling CDN delivery
# of static assets with improved performance and caching.
# resource "digitalocean_record" "cdn_cname" {
#   domain = var.login
#   type   = "CNAME"
#   name   = "cdn"
#   value  = "beehive.ams3.cdn.digitaloceanspaces.com."
# }
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

resource "digitalocean_record" "ovh_authentik_a" {
  domain = var.login
  type   = "A"
  name   = "authentik2"
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