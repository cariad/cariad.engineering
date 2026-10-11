# Scaleway can limit an API key's access to Object Storage only by project (not
# by bucket, as you might expect), so the bucket gets its own project.
resource "scaleway_account_project" "state" {
  description = "OpenTofu state for cariad.engineering"
  name        = "cariad-engineering-tofu-state"
}
