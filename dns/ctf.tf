resource "digitalocean_record" "ctf_a" {
  domain = var.login
  type   = "A"
  name   = "ctf"
  value  = "129.241.150.18"
}

resource "digitalocean_record" "practice_ctf_a" {
  domain = var.login
  type   = "A"
  name   = "practice.ctf"
  value  = "68.183.66.181"
}

resource "digitalocean_record" "skyhigh_ctf_a" {
  domain = var.login
  type   = "A"
  name   = "skyhigh.ctf"
  value  = "129.241.150.243"
}

resource "digitalocean_record" "rebus_ctf_a" {
  domain = var.login
  type   = "A"
  name   = "rebus"
  value  = "129.241.150.118"
}