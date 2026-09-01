# Domeneshop module

A read-only module that queries the Domeneshop API for the registered domains.

## Secrets

- DOMENESHOP_TOKEN: A Domeneshop API token
- DOMENESHOP_SECRET: A Domeneshop API secret

## Output

- domain_names: [string] A list of all the domains we have
- nameservers: { domain => [string] } Current registry nameservers per domain
