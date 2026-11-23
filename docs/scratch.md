# Deploying your own site from scratch

This guide is for copying this repository to deploy a site of your own.

The infrastructure is built from two OpenTofu modules:

- [cariad/terraform-scaleway-tofu-state](https://github.com/cariad/terraform-scaleway-tofu-state) deploys the state backend in `infra/state-backend`, which keeps the website's OpenTofu state.
- [cariad/terraform-bunnynet-static-site](https://github.com/cariad/terraform-bunnynet-static-site) deploys the website in `infra/website`.

Each module's usage guide is the authority on setting it up, so this guide doesn't repeat them. It says which of their steps to follow, and how this repository fits around them.

## Prerequisites

- [Mise](https://mise.jdx.dev/) >= 2026.11.8
- Everything in the prerequisites of [cariad/terraform-scaleway-tofu-state](https://github.com/cariad/terraform-scaleway-tofu-state#prerequisites) and [cariad/terraform-bunnynet-static-site](https://github.com/cariad/terraform-bunnynet-static-site#prerequisites), except OpenTofu, which mise installs, and somewhere to keep the state, which this guide deploys.

## Copying the repository

1. Make your own copy of this repository, then clone it and change into its directory.

1. Install the project's dependencies, including OpenTofu.

   ```bash
   mise install
   ```

## Deploying the state backend

1. In `infra/state-backend/main.tf`, change `bucket` and `workload` to your own values, and optionally set `region`, as described in the [usage guide for cariad/terraform-scaleway-tofu-state](https://github.com/cariad/terraform-scaleway-tofu-state#usage). The bucket name must be globally unique, and this site's is already taken.

1. Follow the [usage guide for cariad/terraform-scaleway-tofu-state](https://github.com/cariad/terraform-scaleway-tofu-state#usage) up to and including generating the API keys for the reader and writer applications, with these differences:

   - The guide's `infra/bootstrap` is `infra/state-backend` here.
   - The files the guide asks you to create already exist, so you don't need to create them.
   - Run the guide's `tofu` commands from the repository's directory, so that mise provides the pinned version of OpenTofu. If your shell doesn't activate mise, prefix them with `mise exec --`.

   The guide's later steps, which configure and initialise your own infrastructure, are handled differently here. The next section covers them. This repository uses the writer key for plans as well as applies, so you won't need the reader key.

## Deploying the website

1. In `infra/website/backend.tf`, change `bucket` to your state backend's bucket name. If you overrode the bucket's region, change `region` and the `s3` endpoint to match.

1. In `infra/website/main.tf`, change `domain`, `prefer_www` and `zone_name` to your own values, as described in the [usage guide for cariad/terraform-bunnynet-static-site](https://github.com/cariad/terraform-bunnynet-static-site#usage). The zone name must be globally unique, and this site's is already taken.

1. Create a `.env` file from the sample.

   ```bash
   cp .env.sample .env
   ```

1. Fill in the values in `.env`:

   - `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` — the API key pair for your state backend's `<workload>-writer` application.
   - `BUNNYNET_API_KEY` — your bunny.net API key. See the [usage guide for cariad/terraform-bunnynet-static-site](https://github.com/cariad/terraform-bunnynet-static-site#usage).

1. Initialise the website infrastructure.

   ```bash
   mise run infra:init
   ```

1. Follow the steps in the website module's usage guide that prepare your domain's DNS. Its other steps are already covered by this repository and this guide.

1. Apply the website infrastructure, confirming the changes when you're happy with the plan.

   ```bash
   mise run infra:apply
   ```

From here on, the [runbook](runbook.md) covers day-to-day operations, with your own repository and names in place of this site's.
