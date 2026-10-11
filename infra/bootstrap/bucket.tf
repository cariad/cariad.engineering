# Holds the OpenTofu state for `infra/blog/`.
#
# `name` and `region` must match `infra/blog/backend.tf`•`terraform`•`backend`.
resource "scaleway_object_bucket" "state" {
  name       = "cariad-engineering-tofu-state-v0"
  project_id = scaleway_account_project.state.id
  region     = "fr-par"

  lifecycle {
    prevent_destroy = true
  }

  lifecycle_rule {
    enabled = true
    id      = "expire-noncurrent-versions"

    noncurrent_version_expiration {
      newer_noncurrent_versions = 10
      noncurrent_days           = 30
    }
  }

  versioning {
    enabled = true
  }
}

# Encrypt the state because it holds bunny.net secrets.
resource "scaleway_object_bucket_server_side_encryption_configuration" "state" {
  bucket     = scaleway_object_bucket.state.name
  project_id = scaleway_object_bucket.state.project_id
  region     = scaleway_object_bucket.state.region

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
