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

CI always runs both.
