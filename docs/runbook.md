# Runbook

This runbook covers the day-to-day operations for maintaining <https://cariad.engineering>, whose infrastructure is already deployed.

To deploy a site of your own from a copy of this repository, see [Deploying your own site from scratch](scratch.md) instead.

## Prerequisites

- [Mise](https://mise.jdx.dev/) >= 2026.11.8

## Setting up a machine

1. Clone this repository.

   ```bash
   git clone git@github.com:cariad/cariad.engineering.git
   ```

1. Change into the repository's directory.

   ```bash
   cd cariad.engineering
   ```

1. Install the project's dependencies.

   ```bash
   mise install
   ```

1. Create a `.env` file from the sample.

   ```bash
   cp .env.sample .env
   ```

1. Fill in the values in `.env`:

   - `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` — an API key pair for the `cariad.engineering-writer` state backend application in Scaleway. See [cariad/terraform-scaleway-tofu-state](https://github.com/cariad/terraform-scaleway-tofu-state/).
   - `BUNNYNET_API_KEY` — your bunny.net API key. See [cariad/terraform-bunnynet-static-site](https://github.com/cariad/terraform-bunnynet-static-site/).

1. Initialise the website infrastructure.

   ```bash
   mise run infra:init
   ```

## Linting

The `lint` task runs all the linters:

```bash
mise run lint
```

The linters also run in CI when a pull request is opened.

## Infrastructure

The `infra:plan` task shows the changes that OpenTofu would make to the website infrastructure:

```bash
mise run infra:plan
```

The `infra:apply` task shows the plan again, then makes the changes when you confirm them:

```bash
mise run infra:apply
```

Infrastructure is not currently deployed in CI — this must be performed locally for now.

## State backend

The state backend is a one-off bootstrap, applied by hand with a Scaleway API key pair and organisation ID set as `SCW_ACCESS_KEY`, `SCW_SECRET_KEY` and `SCW_DEFAULT_ORGANIZATION_ID`. Its state lives only in `infra/state-backend/terraform.tfstate`, which Git ignores, so restore the backed-up copy before running OpenTofu in `infra/state-backend` — otherwise OpenTofu will try to create everything again.
