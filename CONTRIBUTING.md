# Contributing

This repository publishes ByteFork Helm charts.

## Requirements

Install:

- Helm
- chart-testing (`ct`)
- kubeconform
- helm-docs
- `helm schema` from `losisin/helm-values-schema-json`
- [Task](https://taskfile.dev) (`brew install go-task/tap/go-task` on macOS)

## Local Workflow

Run all checks:

```sh
task check
```

Available tasks (`task --list` shows the same):

- `task lint` - chart-testing lint across all charts
- `task render` - render every CI scenario and validate with kubeconform
- `task schema` - regenerate `values.schema.json` files
- `task schema:check` - verify schemas are up to date
- `task docs` - regenerate helm-docs READMEs
- `task docs:check` - verify READMEs are up to date
- `task deps` - rebuild chart dependencies

CI runs the same checks inline in `.github/workflows/pr.yaml`. Before opening a PR, run `task check` locally.

## Chart Conventions

- Chart versions use SemVer and start at `0.0.1`.
- `version` is the chart/package version.
- `appVersion` is the application/image version.
- CI render scenarios live at `charts/<chart>/ci/<scenario>-values.yaml` and are wired into `task render` and the GitHub Actions workflow.
- Keep `values.yaml`, `values.schema.json`, and generated README files in sync.
- Prefer secure defaults: non-root pods, dropped capabilities, no service account token automount unless needed.
- Optional integrations such as ingress, monitoring, autoscaling, disruption budgets, and network policies should be disabled by default.

## Documentation And Schema

Regenerate docs and schemas after changing chart values:

```sh
task docs
task schema
```

Verify generated files are current:

```sh
task docs:check
task schema:check
```

## Pull Requests

- Keep changes focused.
- The repository is currently pre-release; chart `version` bumps are not enforced in CI yet. Once the first published release ships, PRs that touch a chart will be required to bump that chart's `version`.
- Update `appVersion` when the default application image changes.
- Run `task check` before opening a PR.
- CI must pass before merge.

## Releasing

Releases are automated by `.github/workflows/release.yaml`, which runs on every push to `main` (and can be triggered manually via `workflow_dispatch`).

The workflow uses [`helm/chart-releaser-action`](https://github.com/helm/chart-releaser-action) with `skip_existing: true`, so it only releases chart versions that are not already in the published index. The flow for shipping a new release:

1. Bump the chart's `version` in `Chart.yaml` (and `appVersion` if the application image changed).
2. Update `values.yaml`, regenerate `values.schema.json` (`task schema`) and READMEs (`task docs`) as needed.
3. Open a PR. CI runs the lint/render/schema/docs checks.
4. Merge to `main`. The release workflow packages the bumped chart, creates a GitHub Release tagged `<chart>-<version>`, and publishes the chart `.tgz` plus an updated `index.yaml` to the `gh-pages` branch.
5. The same workflow syncs `README.md` to `gh-pages`. GitHub Pages renders `README.md` as the chart-repo landing page using the default Jekyll theme, so the same file serves both the GitHub repo landing and `https://bytefork.github.io/helm-charts/`.

### Bootstrap (one-time)

- Enable GitHub Pages for the repository, set source to the `gh-pages` branch root.

### Branch protection

`main` should require the `Charts` PR check to pass before merge. Configure under repository Settings -> Branches -> Branch protection rules.

## License

Contributions are licensed under the [MIT License](LICENSE).
