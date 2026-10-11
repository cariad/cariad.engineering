# Infrastructure

## Overview

The blog's infrastructure is managed by [OpenTofu](https://opentofu.org) in two modules:

- `infra/blog` — the functional stuff (content hosting, delivery network, etc), deployed to [bunny.net](https://bunny.net).
- `infra/bootstrap` — a bucket in [Scaleway](https://www.scaleway.com) to hold OpenTofu's state for the bunny.net deployment.

The bootstrap is the only step that must be run on your local machine. You *can* plan changes to the blog's infrastructure locally, but this repository's GitHub Actions will show a plan of each PR's changes in its comments, and will apply those changes when you merge the PR to the `main` branch.

## Before you start

- Follow the [setup guide](../docs/setup.md).
- You'll need Scaleway and bunny.net accounts.

## 1. Bootstrap the state storage

This creates the state bucket, its Scaleway project, and two applications: one that can read the state, and one that can also write it.

This is the **only** infrastructure you deploy from your own machine.

1. In the Scaleway console, generate an API key for yourself that expires in an hour.

   If Scaleway asks if the key will be used for Object Storage, say *no*. We'll be deploying Object Storage, but not reading from/writing to it.

1. Set the key and your organisation's ID as these environment variables:

   ```bash
   export SCW_ACCESS_KEY="..."
   export SCW_SECRET_KEY="..."
   export SCW_DEFAULT_ORGANIZATION_ID="..."
   ```

1. If you've applied the bootstrap before, copy your backed-up `terraform.tfstate` into `infra/bootstrap/`. Without it, OpenTofu will try to create everything again.

1. Initialise the bootstrap:

   ```bash
   tofu -chdir=infra/bootstrap init
   ```

1. Review the plan and apply it:

   ```bash
   tofu -chdir=infra/bootstrap apply
   ```

1. Delete your one-hour API key in the Scaleway console.

1. Back up `infra/bootstrap/terraform.tfstate`. The bootstrap can't keep its state in the bucket it creates, so that file, which Git ignores, is its only record. **Keep it safe!**

## 2. Create the API keys

OpenTofu doesn't create these, because it would store their secrets in the bootstrap's state.

1. In the Scaleway console, look for any policy whose principal is the "All Applications" group or `AllApps`. If there is one, remove it or narrow its principal, or it'll give these applications more access than their own policies do.

1. Generate an API key for each of the two applications that the bootstrap created:

   - `cariad-engineering-tofu-state-reader`.
   - `cariad-engineering-tofu-state-writer`.

   Set each key's preferred Object Storage project to `cariad-engineering-tofu-state`, or OpenTofu won't find the bucket.

   New policies can take up to 5 minutes to take effect, so if a key gets "access denied" straight after the bootstrap, wait a few minutes and try again.

1. Store both keys somewhere safe.
