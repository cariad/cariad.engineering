module "site" {
  source = "git::https://github.com/cariad/terraform-bunnynet-static-site.git?ref=v0.1.0"

  domain     = "cariad.engineering"
  prefer_www = false
  zone_name  = "cariad-engineering-202611221310"
}
