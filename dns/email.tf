locals {
  whitelist_domains = [
    {
      domain = "login.no"
      name   = "@"
      spf    = "v=spf1 include:emailsrvr.com ~all"
      dkim = {
        selector = "20221010-xpztq0z9"
        key      = "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDx+Vek3w/EJdI45vWGjjYKdlLxkv1tl1T/6pR2pKyC//6SQDUTQJv7zpoFii8Ai4jLfW88du9MegqorSwY8/bTEbylhbyHQ/7xZcQntTZ43lL4EJc7pk7bw+FZIxBziKLNhejJhx+SlhpOTQkvyc/E+DK/pB14YhbMx2XiZjjD2QIDAQAB"
      }
      mx_records = [
        {
          value    = "mx1.emailsrvr.com."
          priority = 10
        },
        {
          value    = "mx2.emailsrvr.com."
          priority = 20
        }
      ]
    },
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
          priority = 10
        },
        {
          value    = "mx2.emailsrvr.com."
          priority = 20
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
        },
        {
          value    = "smtp.google.com."
          priority = 40
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
          priority = 30
        },
        {
          value    = "smtp.google.com."
          priority = 40
        }
      ]
    }
  ]
  email_domains = [
    for d in local.whitelist_domains : d.domain
  ]
  blacklist_domains = [for d in module.domains.domain_names : d if !contains(local.email_domains, d)]
}

// --------------------- Whitelist ---------------------
locals {
  // Flatten MX records for all whitelisted domains
  mx_records = flatten([
    for domain in local.whitelist_domains : [
      for mx in domain.mx_records : {
        domain   = domain.domain
        name     = domain.name
        value    = mx.value
        priority = mx.priority
      }
    ]
  ])
}

resource "digitalocean_record" "mx_record" {
  for_each = tomap({ for rec in local.mx_records : "${rec.domain}-${rec.name}-${rec.value}-${rec.priority}" => rec })
  domain   = each.value.domain
  type     = "MX"
  name     = each.value.name
  value    = each.value.value
  priority = each.value.priority
}

resource "digitalocean_record" "spf_allow" {
  for_each = { for c in local.whitelist_domains : "${c.domain}-${c.name}-${c.spf}" => c }
  domain   = each.value.domain
  type     = "TXT"
  name     = each.value.name
  value    = each.value.spf
}

resource "digitalocean_record" "dkim_allow" {
  for_each = { for c in local.whitelist_domains : "${c.domain}-${c.name}-${c.dkim.selector}" => c }
  domain   = each.value.domain
  type     = "TXT"
  name     = "${each.value.dkim.selector}._domainkey${each.value.name == "@" ? "" : ".${each.value.name}"}"
  value    = each.value.dkim.key
}

// --------------------- Blacklist ---------------------
# Blocks all SPF (Sender Policy Framework) email sending for the specified domains.
resource "digitalocean_record" "spf_block" {
  for_each = toset(local.blacklist_domains)
  domain   = each.key
  type     = "TXT"
  name     = "@"
  value    = "v=spf1 -all"
}

# Blocks any DKIM (DomainKeys Identified Mail) signatures for the specified domains.
resource "digitalocean_record" "dkim_block" {
  for_each = toset(local.blacklist_domains)
  domain   = each.key
  name     = "*._domainkey"
  type     = "TXT"
  value    = "v=DKIM1; p="
}

// --------------------- DMARC ---------------------
resource "digitalocean_record" "dmarc_whitelist" {
  for_each = { for c in local.whitelist_domains : "${c.domain}-${c.name}-${c.dkim.selector}" => c }
  domain   = each.value.domain
  type     = "TXT"
  name     = "_dmarc${each.value.name == "@" ? "" : ".${each.value.name}"}"
  value    = "v=DMARC1; p=reject; sp=reject; adkim=s; aspf=s; rua=mailto:postmaster@login.no"
}

resource "digitalocean_record" "dmarc_blacklist" {
  for_each = toset(local.blacklist_domains)
  domain   = each.key
  name     = "_dmarc"
  type     = "TXT"
  value    = "v=DMARC1; p=reject; sp=reject; adkim=s; aspf=s; rua=mailto:postmaster@login.no"
}

# TODO:
# - Remove DO_create domain module
# - Add domain resource for all domains
# - Add A record for all domains pointing
# - Remove git.logntnu.no mx records
# - Clean up logntnu.tf
# - Check the configuration