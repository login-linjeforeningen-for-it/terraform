output "domain_names" {
  value = data.domeneshop_domains.domains.domains[*].domain
}

output "nameservers" {
  description = "Current registry nameservers per domain"
  value       = { for domain in data.domeneshop_domains.domains.domains : domain.domain => domain.nameservers }
}
