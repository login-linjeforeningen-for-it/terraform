<div align="center">

<img src="https://s3.login.no/beehive/img/logo/logo-white-small.svg" alt="Login logo" width="80" height="80" />

<h1>Terraform</h1>

<p>
  <img src="https://img.shields.io/badge/OpenTofu-fd8738?style=flat-square&logo=opentofu&logoColor=white" alt="OpenTofu" />
  <img src="https://img.shields.io/badge/OVHcloud-fd8738?style=flat-square&logo=ovh&logoColor=white" alt="OVHcloud" />
  <img src="https://img.shields.io/badge/S3-fd8738?style=flat-square&logo=amazons3&logoColor=white" alt="S3" />
</p>

</div>

---

Terraform configuration for Login infrastructure. Manages DNS records in OVHcloud, syncing domains from Domeneshop, and provisions supporting infrastructure modules.

State is stored in an S3-compatible backend on OVH.

## Getting Started

1. **Export credentials**

   ```bash
   export AWS_ACCESS_KEY_ID=...        # OVH Object Storage key (Terraform state)
   export AWS_SECRET_ACCESS_KEY=...
   export OVH_APPLICATION_KEY=...      # OVH API (region ovh-ca) - DNS records
   export OVH_APPLICATION_SECRET=...
   export OVH_CONSUMER_KEY=...
   export DOMENESHOP_TOKEN=...         # Domeneshop API - domain list data source
   export DOMENESHOP_SECRET=...
   ```

2. **Initialize and apply**

   ```bash
   cd dns
   tofu init
   tofu apply
   ```

## Project Structure

- `dns/` - DNS records for all Login domains managed in OVHcloud
- `dns/modules.tf` - Pulls domain names from the Domeneshop module
- `modules/domeneshop/` - Reads domains registered in Domeneshop
