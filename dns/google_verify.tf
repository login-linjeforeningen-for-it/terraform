resource "ovh_domain_zone_record" "google_verify_root" {
  zone      = var.login
  subdomain = ""
  fieldtype = "TXT"
  ttl       = var.ttl
  target    = join(" ", formatlist("%q", regexall(".{1,255}", "google-site-verification=WDHZtpjiTEsnySmCP-lQUQibvV7pFbHcIC4cG_gWUxU")))
}

resource "ovh_domain_zone_record" "google_verify_forms" {
  zone      = var.login
  subdomain = "forms"
  fieldtype = "TXT"
  ttl       = var.ttl
  target    = join(" ", formatlist("%q", regexall(".{1,255}", "google-site-verification=ryrYCeqvEF5EDnpjioRq1DIyY6PByK-LbtkFwcI7m-c")))
}
