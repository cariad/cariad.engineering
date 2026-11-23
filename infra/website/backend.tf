terraform {
  backend "s3" {
    bucket                      = "cariad-engineering-state-202611221005"
    key                         = "website/terraform.tfstate"
    region                      = "fr-par"
    skip_credentials_validation = true # Scaleway has no AWS STS
    skip_metadata_api_check     = true # Scaleway has no AWS EC2 metadata service
    skip_region_validation      = true # Scaleway uses different region codes
    skip_requesting_account_id  = true # Scaleway has no AWS account ID
    use_lockfile                = true

    endpoints = {
      s3 = "https://s3.fr-par.scw.cloud"
    }
  }
}
