locals {
  hypnet_domains = toset([
    "agni.no",
    "ingalinjeforeningen.no",
    "lnga.no",
    "lngalinjeforening.no",
    "tekkom.no",
  ])

  managed_domains = tolist(setsubtract(toset(module.domeneshop.domain_names), local.hypnet_domains))
}
