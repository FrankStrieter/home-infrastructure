resource "cloudflare_list" "fail2ban" {
  account_id = var.cloudflare_account_id
  name        = "hostile_ips"
  kind        = "ip"
  description = "IPs blocked by Fail2Ban"
}

resource "cloudflare_ruleset" "fail2ban" {
  zone_id = var.cloudflare_zone_id
  name    = "Fail2Ban"
  kind    = "zone"
  phase   = "http_request_firewall_custom"
  rules = [{
    action = "block"
    enabled = true
    expression = <<EOT
      ip.src.country in {"US" "NL" "IT"} or ip.src in $hostile_ips
		EOT
    description = "Block Fail2Ban IPs and specific countries"
  }]
}

# data "cloudflare_api_token_permission_groups" "all" {}

output "fail2ban_list_id" {
  value = cloudflare_list.fail2ban.id
}

output "fail2ban_list_name" {
  value = cloudflare_list.fail2ban.name
}
