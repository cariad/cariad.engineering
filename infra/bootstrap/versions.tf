terraform {
  # Keep in sync with `.config/mise.toml`•`tools`•`opentofu`:
  required_version = "~> 1.12.6"

  required_providers {
    # Nothing updates the version for us. Check for new releases now and then at
    # https://github.com/scaleway/terraform-provider-scaleway/releases, but
    # don't take a release younger than a week.
    #
    # After bumping `version`, run `tofu init -upgrade` to update the lock file.
    scaleway = {
      source  = "scaleway/scaleway"
      version = "~> 2.83.1"
    }
  }
}
