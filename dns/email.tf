locals {
  whitelist_domains = [
    {
      domain = "logntnu.no"
      name   = "@"
      spf    = "v=spf1 include:emailsrvr.com ~all"
      dkim = {
        selector = "20221012-tfsz5nkw"
        key      = "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDb2zbqNd8ktaADYvbrzNITX1prrfvdP/gezIsIz9ippJvrryhWYlILMRRmENogtcB8zL7ky19FXfkUUWsMRnO7wGaI7b2M7NkWzkX5htsjdxHej6AEBzacrzfPu3e1ly2YFwZn5z+GPt7tHv0oRMq//mDDR9pKyjxhLm19ltoJfQIDAQAB"
      }
      mx_records = [
        {
          value    = "mx1.emailsrvr.com."
          priority = 30
        },
        {
          value    = "mx2.emailsrvr.com."
          priority = 40
        }
      ]
    },
    {
      domain = "login.no"
      name   = "forms"
      spf    = "v=spf1 include:_spf.google.com ~all"
      dkim = {
        selector = "google"
        key      = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqY2snzperstV2twAJ1aXInjDPA4BLM31KK8kR/EMgWmkNIL+yZ6+QtkKQQOrPWtblzBbHh/SG0kodnPGwbcQuWiq6sB5NA64wKVxBQEAUCK2TnjMHjUwjYIs7u5KP3wlxILL6XIwTzo5Jhh0K1D2DLujwQuzTzkQR51/i+mOB394925jT5yU4ME1CM+HAHxi2UTK6/u9mHRFbLdNNfzbYNEqC3vNCfHN4y26JCH8GResMfBzaWWTXIfeXjRGkTaRFdd2D4GF39CLb/NaXX3zopYI+QCY3F1y/KYQjYPVpGSzxoAY208TdTjj7YMaGTi1eMeoCsAZSfrqVWD1nWEiVQIDAQAB"
      }
      mx_records = [
        {
          value    = "smtp.google.com."
          priority = 30
        }
      ]
    },
    {
      domain = "login.no"
      name   = "vault"
      spf    = "v=spf1 include:_spf.google.com ~all"
      dkim = {
        selector = "google"
        key      = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA1UyFVEOjE/yFSGJW4ah3GpDzy6SlK9Fio1W572o8hkremSfWS+eLC38u7q+5ZcvGqM4vif3+Pgc6lX3IVQ5cojpyc/8yrlq4hJk8efwulyAvSsMqoL/8sDwtby8g9aiy+c4qqnGKUFMf+s0+dWiByMKvFQcJNfmMYUK4Xg1Anodo0cOZvKDk7C+sdegq49cDCcLn9lTDI6YeSpYkkwtPACHUuaB2uaBQypUwls3AJKkZHQC/U1oxkY9G3bwwbDVDn1C16i+8zKyadVImsLD/yJQ4i2DqUoHsN0N+0VoiYo3T24J8g4KScyRycLEpszB1OQbAQWLLO4KBWUE1sN8K5QIDAQAB"
      }
      mx_records = [
        {
          value    = "smtp.google.com."
          priority = 30
        }
      ]
    },
    {
      domain = "login.no"
      name   = "@"
      spf    = "v=spf1 include:_spf.google.com ~all"
      dkim = {
        selector = "google"
        key      = "v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmxPBtlPOfUOSS1kq/ue7Iey5DMBNCn0EZeryQZV34/UEujtg153GK22+tbjLIi89fvPo3BoqpzbPtloldYA9yOt7uIAFgerTTOPEE0JvWKA6gTDgcndX6z4S/OE7GqnnidR55ePvNSI7xsDJDip3K9sVtCATm8PJz213Zy/tSivASARRqYiCITD5VzwIjgg3RsQ/6PPg0KR88WILhEGt44NPSGDQ1omVyBC7e3yFk5e9t2259snthXAYeO7KahyHremxAgz9nKLMt9XUECCv5WeiXqBC6nP/WK26BosbKg4kX20+8b9McmfZNBrGoNMtr9403iwh0Lb/p7D+0/xEqwIDAQAB"
      }
      mx_records = [
        {
          value    = "smtp.google.com."
          priority = 10
        }
      ]
    }
  ]

  email_domains = [for d in local.whitelist_domains : d.domain]

  blacklist_domains = [for d in local.managed_domains : d if !contains(local.email_domains, d)]

  dmarc_policy = "v=DMARC1; p=reject; sp=reject; adkim=s; aspf=s; rua=mailto:postmaster@${var.login}"

  # Keyed by "<zone>-<name>", with the "@" -> "" subdomain translation applied once.
  whitelist = {
    for c in local.whitelist_domains : "${c.domain}-${c.name}" => merge(c, {
      sub = c.name == "@" ? "" : c.name
    })
  }

  mx_records = merge([
    for key, c in local.whitelist : {
      for mx in c.mx_records : "${key}-${mx.value}-${mx.priority}" => {
        domain    = c.domain
        subdomain = c.sub
        target    = "${mx.priority} ${mx.value}"
      }
    }
  ]...)
}

# --------------------- Whitelist ---------------------

resource "ovh_domain_zone_record" "mx_record" {
  for_each  = local.mx_records
  zone      = each.value.domain
  subdomain = each.value.subdomain
  fieldtype = "MX"
  ttl       = var.ttl
  target    = each.value.target
}

resource "ovh_domain_zone_record" "spf_allow" {
  for_each  = local.whitelist
  zone      = each.value.domain
  subdomain = each.value.sub
  fieldtype = "TXT"
  ttl       = var.ttl
  target    = join(" ", formatlist("%q", regexall(".{1,255}", each.value.spf)))
}

resource "ovh_domain_zone_record" "dkim_allow" {
  for_each  = local.whitelist
  zone      = each.value.domain
  subdomain = "${each.value.dkim.selector}._domainkey${each.value.sub == "" ? "" : ".${each.value.sub}"}"
  fieldtype = "TXT"
  ttl       = var.ttl
  target    = join(" ", formatlist("%q", regexall(".{1,255}", each.value.dkim.key)))
}

resource "ovh_domain_zone_record" "dmarc_whitelist" {
  for_each  = local.whitelist
  zone      = each.value.domain
  subdomain = "_dmarc${each.value.sub == "" ? "" : ".${each.value.sub}"}"
  fieldtype = "TXT"
  ttl       = var.ttl
  target    = join(" ", formatlist("%q", regexall(".{1,255}", local.dmarc_policy)))
}

# --------------------- Blacklist: parked domains send no mail ---------------------

resource "ovh_domain_zone_record" "spf_block" {
  for_each  = toset(local.blacklist_domains)
  zone      = each.key
  subdomain = ""
  fieldtype = "TXT"
  ttl       = var.ttl
  target    = join(" ", formatlist("%q", regexall(".{1,255}", "v=spf1 -all")))
}

resource "ovh_domain_zone_record" "dkim_block" {
  for_each  = toset(local.blacklist_domains)
  zone      = each.key
  subdomain = "*._domainkey"
  fieldtype = "TXT"
  ttl       = var.ttl
  target    = join(" ", formatlist("%q", regexall(".{1,255}", "v=DKIM1; p=")))
}

resource "ovh_domain_zone_record" "dmarc_blacklist" {
  for_each  = toset(local.blacklist_domains)
  zone      = each.key
  subdomain = "_dmarc"
  fieldtype = "TXT"
  ttl       = var.ttl
  target    = join(" ", formatlist("%q", regexall(".{1,255}", local.dmarc_policy)))
}

resource "ovh_domain_zone_record" "dmarc_report_auth" {
  for_each  = var.enable_dmarc_report_authorization ? toset([for d in local.managed_domains : d if d != var.login]) : toset([])
  zone      = var.login
  subdomain = "${each.value}._report._dmarc"
  fieldtype = "TXT"
  ttl       = var.ttl
  target    = join(" ", formatlist("%q", regexall(".{1,255}", "v=DMARC1")))
}
