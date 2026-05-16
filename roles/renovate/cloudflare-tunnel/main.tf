resource "cloudflare_zero_trust_tunnel_cloudflared" "tunnel" {
  account_id = var.cloudflare_account_id
  name = "Tunnel for ${var.domain}"
  config_src = "cloudflare"
}

output "tunnel_token" {
  description = "Token of the tunnel"
  sensitive = true
  value = data.cloudflare_zero_trust_tunnel_cloudflared_token.tunnel_token
}

# Reads the token used to run the tunnel on the server.
data "cloudflare_zero_trust_tunnel_cloudflared_token" "tunnel_token" {
  account_id = var.cloudflare_account_id
  tunnel_id = cloudflare_zero_trust_tunnel_cloudflared.tunnel.id
}

resource "cloudflare_zero_trust_tunnel_cloudflared_config" "tunnel_config" {
  account_id = var.cloudflare_account_id
  tunnel_id = cloudflare_zero_trust_tunnel_cloudflared.tunnel.id
  config = {
    ingress = [{
      hostname = var.domain
      # domain is also registered in the routers DNS with the local IP
      service = "https://${var.domain}"
    },
    {
      # catchall
      service = "http_status:404"
    }]
  }
}

resource "cloudflare_dns_record" "app" {
  zone_id = var.cloudflare_zone_id
  name = split(".", var.domain)[0]
  content = "${cloudflare_zero_trust_tunnel_cloudflared.tunnel.id}.cfargotunnel.com"
  type = "CNAME"
  ttl = 1
  proxied = true
}
