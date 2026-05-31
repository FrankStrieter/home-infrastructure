variable "cloudflare_account_id" {
  description = "Account ID for your Cloudflare account"
  type        = string
  sensitive   = true
}

variable "cloudflare_token" {
  description = "Cloudflare API token"
  type        = string
  sensitive   = true
}

variable "cloudflare_zone_id" {
  description = "foo"
  type = string
}
