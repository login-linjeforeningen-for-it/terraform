locals {
  excluded     = [var.logout, var.login]
  domain_names = [for d in module.domeneshop.domain_names : d if contains(local.excluded, d) == false]
}

resource "digitalocean_record" "cname_records" {
  for_each = toset(local.domain_names)

  domain = each.value
  name   = "@"
  type   = "CNAME"
  value  = "${var.login}."

}