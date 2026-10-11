# Plans and applies reach the state through API keys belonging to these
# applications. We create the keys by hand in the Scaleway console, because
# OpenTofu would store their secrets in this module's state.

# For plans, which only read the state and don't take its lock.
resource "scaleway_iam_application" "state_reader" {
  description = "Reads the OpenTofu state for cariad.engineering"
  name        = "cariad-engineering-tofu-state-reader"
}

resource "scaleway_iam_policy" "state_reader" {
  application_id = scaleway_iam_application.state_reader.id
  description    = "Read the OpenTofu state for cariad.engineering"
  name           = "cariad-engineering-tofu-state-reader"

  rule {
    permission_set_names = ["ObjectStorageObjectsRead"]
    project_ids          = [scaleway_account_project.state.id]
  }
}

# For applies, which read and write the state, and take and release its lock.
resource "scaleway_iam_application" "state_writer" {
  description = "Reads and writes the OpenTofu state for cariad.engineering"
  name        = "cariad-engineering-tofu-state-writer"
}

resource "scaleway_iam_policy" "state_writer" {
  application_id = scaleway_iam_application.state_writer.id
  description    = "Read and write the OpenTofu state for cariad.engineering"
  name           = "cariad-engineering-tofu-state-writer"

  rule {
    # Releasing the state lock deletes its lock file.
    permission_set_names = [
      "ObjectStorageObjectsDelete",
      "ObjectStorageObjectsRead",
      "ObjectStorageObjectsWrite",
    ]
    project_ids = [scaleway_account_project.state.id]
  }
}
