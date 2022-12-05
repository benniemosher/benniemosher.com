
locals {
  cloudflare-zones = [
    {
      name = "benniemosher.dev"
      dns-records = [
        {
          name  = "_domainconnect"
          value = "connect.domains.google.com"
        },
        {
          name  = "www"
          value = "benniemosher.dev"
        },
        {
          name    = "_github-challenge-benniemosher-dev-org"
          proxied = false
          type    = "TXT"
          value   = "49eb4ab98b"
        },
        {
          name     = "benniemosher.dev"
          priority = 69
          type     = "MX"
          value    = "route1.mx.cloudflare.net"
          proxied  = false
        },
        {
          name     = "benniemosher.dev"
          priority = 96
          type     = "MX"
          value    = "route2.mx.cloudflare.net"
          proxied  = false
        },
        {
          name     = "benniemosher.dev"
          priority = 25
          type     = "MX"
          value    = "route3.mx.cloudflare.net"
          proxied  = false
        },
        {
          name    = "benniemosher.dev"
          type    = "TXT"
          value   = "v=spf1 include:_spf.mx.cloudflare.net ~all"
          proxied = false
        }
      ]
    }
  ]
}
