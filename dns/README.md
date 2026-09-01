# DNS

DNS records for all in-scope Login domains, hosted on **OVHcloud** (region
`ovh-ca`). Zones are created out of band; this stack manages only the records.
Domain list comes from the Domeneshop module.

The 5 domains on Domeneshop managed DNS (`ns*.hyp.net`) are excluded via
`local.hypnet_domains` in `locals.tf`.

## Required secrets

State (OVH Object Storage, S3-compatible):
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

OVH API (DNS records):
- `OVH_APPLICATION_KEY`
- `OVH_APPLICATION_SECRET`
- `OVH_CONSUMER_KEY`

Domeneshop API (domain list data source):
- `DOMENESHOP_TOKEN`
- `DOMENESHOP_SECRET`
