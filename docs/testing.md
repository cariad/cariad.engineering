# Testing

## Lint

To lint everything except the infrastructure, run:

```bash
mise run lint-content
```

If you've changed anything in `infra/`, also run:

```bash
mise run lint-infra
```

`lint-infra` doesn't need any infrastructure credentials on a fresh clone, but once you've run `mise run infra:blog`, OpenTofu remembers that the blog's state is in the Scaleway bucket, and `lint-infra` connects to the bucket too.

From then on, it needs the `.env` file you [created](../infra/README.md#2-create-the-api-keys) for planning infrastructure changes, which mise loads for it — or delete `infra/blog/.terraform/` to lint without credentials.

CI always runs both.
