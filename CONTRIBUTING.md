# Contributing

Thanks for your interest in improving this project!

## Workflow

1. Fork the repo and create a branch from `main`: `git checkout -b feat/my-change`
2. Make your change in small, focused commits.
3. Run the checks locally before pushing:
   ```bash
   cd app
   npm run lint
   npm test
   ```
4. Open a pull request against `main`. CI must pass before merging.

## Commit messages

Use [Conventional Commits](https://www.conventionalcommits.org/):

- `feat: add pagination to /api/items`
- `fix: return 404 for unknown item`
- `docs: update README`
- `ci: cache npm dependencies`

## Rules

- Never commit secrets, tokens or `.env` files. Secret scanning runs on every PR.
- Add or update tests for any behaviour change.
- Keep the Docker image non-root and minimal.
- Infrastructure changes: run `terraform fmt` and `terraform validate`.

## Reporting security issues

Please do not open a public issue. Contact the maintainer privately instead.
