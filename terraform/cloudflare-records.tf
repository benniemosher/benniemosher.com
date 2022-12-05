resource "cloudflare_record" "this" {
  for_each = merge([
    for zone in local.cloudflare-zones : {
      for record in zone.dns-records :
      record.name => merge(record, { zone-id = cloudflare_zone.this[zone.name].id })
    }
  ]...)

  zone_id = each.value.zone-id
  name    = each.value.name
  type    = try(each.value.type, "CNAME")
  value   = each.value.value
  proxied = try(each.value.proxied, true)
}
