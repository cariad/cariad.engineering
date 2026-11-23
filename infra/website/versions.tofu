language {
  compatible_with {
    opentofu = "~> 1.12.0"
  }
}

terraform {
  required_providers {
    bunnynet = {
      source  = "BunnyWay/bunnynet"
      version = "~> 0.19.1"
    }
  }
}
