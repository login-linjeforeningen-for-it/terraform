variable "login" {
  type        = string
  description = "login.no domain name"
  default     = "login.no"
}

variable "logout" {
  type        = string
  description = "logout.no domain name"
  default     = "logout.no"
}

variable "onprem_mgmt_ip" {
  type        = string
  description = "The IP of the onprem management server"
  default     = "128.39.140.144"
}

variable "onprem_ip" {
  type        = string
  description = "The IP of the onprem proxy"
  default     = "128.39.142.138"
}

variable "offprem_ip" {
  type        = string
  description = "The IP of the offprem server"
  default     = "57.129.124.84"
}

variable "enable_dmarc_report_authorization" {
  type        = bool
  description = "Publish <domain>._report._dmarc.login.no TXT so external receivers send DMARC aggregate reports to postmaster@login.no (RFC 7489 7.1)."
  default     = true
}
