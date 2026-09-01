output "managed_domains" {
  description = "The domains this stack manages (Domeneshop list minus the hyp.net set)."
  value       = local.managed_domains
}

output "domain_nameservers" {
  description = "Registry nameservers per Domeneshop domain"
  value       = module.domeneshop.nameservers
}
