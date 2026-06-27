<div align="center">

<img src="https://s3.login.no/beehive/img/logo/logo-white-small.svg" alt="Login logo" width="80" height="80" />

<h1>Terraform</h1>

<p>
  <img src="https://img.shields.io/badge/Terraform-fd8738?style=flat-square&logo=terraform&logoColor=white" alt="Terraform" />
  <img src="https://img.shields.io/badge/DigitalOcean-fd8738?style=flat-square&logo=digitalocean&logoColor=white" alt="DigitalOcean" />
  <img src="https://img.shields.io/badge/OVH-fd8738?style=flat-square&logo=ovh&logoColor=white" alt="OVH" />
  <img src="https://img.shields.io/badge/S3-fd8738?style=flat-square&logo=amazons3&logoColor=white" alt="S3" />
</p>

</div>

---

Terraform configuration for Login infrastructure. Manages DNS records in DigitalOcean, syncing domains from Domeneshop, and provisions supporting infrastructure modules.

State is stored in an S3-compatible backend on OVH.

## Getting Started

1. **Export credentials**

   ```bash
   export AWS_ACCESS_KEY_ID=...
   export AWS_SECRET_ACCESS_KEY=...
   export DIGITALOCEAN_TOKEN=...
   ```

2. **Initialize and apply**

   ```bash
   cd dns
   terraform init
   terraform apply
   ```

## Project Structure

- `dns/` - DNS records for all Login domains managed in DigitalOcean
- `dns/modules.tf` - Pulls domain names from the Domeneshop module
- `modules/domeneshop/` - Reads domains registered in Domeneshop
