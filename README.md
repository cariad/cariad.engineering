# cariad.engineering

Hello! 👋 This repository *will* describe the infrastructure, website, and content for my software engineering blog at <https://cariad.engineering>, but it's rather bare while I'm still pulling it all together.

## Prerequisites

- [Mise](https://mise.jdx.dev/) >= 2026.11.8

## Quick start

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

## Linting

The `lint` task runs all the linters:

```bash
mise run lint
```

The linters also run in CI when a pull request is opened.
