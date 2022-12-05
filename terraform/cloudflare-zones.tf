resource "cloudflare_zone" "this" {
  for_each = { for zone in local.cloudflare-zones : zone.name => zone }

  account_id = var.cloudflare-config.account-id
  jump_start = try(each.value.jump-start, null)
  paused     = try(each.value.paused, null)
  plan       = try(each.value.plan, "free")
  type       = try(each.value.type, "full")
  zone       = each.value.name
}
