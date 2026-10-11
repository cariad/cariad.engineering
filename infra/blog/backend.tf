# Keep the blog's state in the bucket that `infra/bootstrap/` creates.
#
# Scaleway Object Storage speaks the S3 API, so we point the `s3` backend at
# Scaleway. The backend reads a Scaleway API key pair from `AWS_ACCESS_KEY_ID`
# and `AWS_SECRET_ACCESS_KEY`.
terraform {
  backend "s3" {
    # `bucket` must match
    # `infra/bootstrap/bucket.tf`•`scaleway_object_bucket.state`.
    bucket = "cariad-engineering-tofu-state-v0"
    key    = "blog/terraform.tfstate"

    # `region` must match:
    # - `infra/bootstrap/bucket.tf`•`scaleway_object_bucket.state`
    # - `endpoints`•`s3` in this block
    region = "fr-par"

    # The region in this URL must match `region`.
    endpoints = {
      s3 = "https://s3.fr-par.scw.cloud"
    }

    # Skip the checks that only work against AWS: Scaleway has no STS to
    # validate credentials, no EC2 metadata service, no AWS account ID, and
    # `fr-par` isn't an AWS region.
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true

    use_lockfile = true
  }
}
