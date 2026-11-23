module "state" {
  source   = "git::https://github.com/cariad/terraform-scaleway-tofu-state.git?ref=v0.1.0"
  bucket   = "cariad-engineering-state-202611221005"
  workload = "cariad.engineering"
}
