output "domain_names" {
  value = data.domeneshop_domains.domains.domains[*].domain
}

output "nameservers" {
  value = alltrue([
    for idx, domain in data.domeneshop_domains.domains.domains : alltrue([
      for i in range(3) : domain.nameservers[i] == "ns${i + 1}.digitalocean.com"
    ])
  ])
}