resource "ovh_domain_zone_record" "logntnu_discord" {
  zone      = "logntnu.no"
  subdomain = "discord"
  fieldtype = "CNAME"
  ttl       = local.ttl_low
  target    = "discord.login.no."
}

resource "ovh_domain_zone_record" "logntnu_autodiscover" {
  zone      = "logntnu.no"
  subdomain = "autodiscover"
  fieldtype = "CNAME"
  ttl       = local.ttl_low
  target    = "autodiscover.emailsrvr.com."
}

resource "ovh_domain_zone_record" "logntnu_git_spf" {
  zone      = "logntnu.no"
  subdomain = "git"
  fieldtype = "TXT"
  ttl       = local.ttl_low
  target    = join(" ", formatlist("%q", regexall(".{1,255}", "v=spf1 include:emailsrvr.com ~all")))
}

resource "ovh_domain_zone_record" "logntnu_git_mx1" {
  zone      = "logntnu.no"
  subdomain = "git"
  fieldtype = "MX"
  ttl       = local.ttl_low
  target    = "10 mx1.emailsrvr.com."
}

resource "ovh_domain_zone_record" "logntnu_git_mx2" {
  zone      = "logntnu.no"
  subdomain = "git"
  fieldtype = "MX"
  ttl       = local.ttl_low
  target    = "20 mx2.emailsrvr.com."
}

resource "ovh_domain_zone_record" "logntnu_git_dmarc" {
  zone      = "logntnu.no"
  subdomain = "_dmarc.git"
  fieldtype = "TXT"
  ttl       = local.ttl_low
  target    = join(" ", formatlist("%q", regexall(".{1,255}", "v=DMARC1; p=quarantine; rua=mailto:tekkom@logntnu.no")))
}
