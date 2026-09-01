locals {
  hypnet_domains = toset([
    "agni.no",
    "ingalinjeforeningen.no",
    "lnga.no",
    "lngalinjeforening.no",
    "tekkom.no",
  ])

  managed_domains = tolist(setsubtract(toset(module.domeneshop.domain_names), local.hypnet_domains))

  low_ttl_zones = toset(["login.no", "logntnu.no"])

  ttl_low = 300
  ttl_std = 3600

  zone_ttl = {
    for d in local.managed_domains : d => contains(local.low_ttl_zones, d) ? local.ttl_low : local.ttl_std
  }
}
