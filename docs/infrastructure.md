# Infrastructure

## State storage

The blog's infrastructure state is held in a [Scaleway](https://www.scaleway.com) Object Storage bucket. The infrastructure for the bucket is described in `infra/bootstrap/`.

`infra/bootstrap/` can't keep its own state in the bucket it creates, so it stays on the machine that applies it, in `infra/bootstrap/terraform.tfstate`. **Back that file up! Keep it safe!**

### Applying the bootstrap

This is the **only** infrastructure you deploy from your local machine.

1. In the Scaleway console, generate an API key for yourself that expires in one hour.
1. Set the key and your organisation's ID in your shell:

   ```bash
   export SCW_ACCESS_KEY="..."
   export SCW_SECRET_KEY="..."
   export SCW_DEFAULT_ORGANIZATION_ID="..."
   ```

1. Initialise the bootstrap module:

   ```bash
   tofu -chdir=infra/bootstrap init
   ```

1. Review and apply the plan:

   ```bash
   tofu -chdir=infra/bootstrap apply
   ```

1. Delete the API key in the Scaleway console.

## Blog

The blog's infrastructure is described in `infra/blog/` and deployed to [bunny.net](https://bunny.net).

### Planning changes

1. Set your bunny.net API key in your shell:

   ```bash
   export BUNNYNET_API_KEY="..."
   ```

1. Show a plan:

   ```bash
   mise run infra:blog
   ```
