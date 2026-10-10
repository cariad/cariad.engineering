# This module creates a bucket to hold the OpenTofu state for `infra/blog/`.
#
# Scaleway can limit an API key's access to Object Storage only by project (not
# by bucket, as you might expect), so the bucket gets its own project.
resource "scaleway_account_project" "state" {
  description = "OpenTofu state for cariad.engineering"
  name        = "cariad-engineering-tofu-state"
}

resource "scaleway_object_bucket" "state" {
  name       = "cariad-engineering-tofu-state"
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
