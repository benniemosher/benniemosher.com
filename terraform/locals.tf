
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
        }
      ]
    }
  ]
}
