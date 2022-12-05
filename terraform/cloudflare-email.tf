resource "cloudflare_email_routing_catch_all" "this" {
  for_each = { for zone in local.cloudflare-zones : zone.name => zone }

  zone_id = cloudflare_zone.this[each.key].id
  name    = "${each.value.name}-catch-all"
  enabled = true

  matcher {
    type = "all"
  }

  action {
    type  = "forward"
    value = ["${replace(each.value.name, ".", "+")}@github.com"]
  }
}
