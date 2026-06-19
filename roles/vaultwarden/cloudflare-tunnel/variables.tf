variable "cloudflare_account_id" {
  description = "Account ID for your Cloudflare account"
  type        = string
  sensitive   = true
}

variable "cloudflare_email" {
  description = "Email address for your Cloudflare account"
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

variable "domain" {
  description = "Domain that will be accessible for the app"
  type = string
}
