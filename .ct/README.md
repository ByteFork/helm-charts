# Chart Testing

This repository uses `helm/chart-testing` for chart lint and schema validation. Render-and-validate (kubeconform) is a separate step in `Taskfile.yml` and `.github/workflows/pr.yaml` rather than a chart-testing additional-command hook, so the lint phase stays focused on what chart-testing does well.

`ct lint` requires the `yamllint` executable for full validation. Without it, you can still run a reduced check (the GitHub Actions workflow installs the full toolchain).

## Layout

- `.ct/ct.yaml` - chart-testing configuration.
- `Taskfile.yml` - local-dev orchestration; `task lint` runs `ct lint --all`.
- `.github/workflows/pr.yaml` - CI runs `ct lint` per changed chart, then renders each CI scenario and pipes to `kubeconform -strict -summary`.

## Render Scenarios

Each chart can declare additional render scenarios under `ci/`:

```text
charts/<chart>/ci/<scenario>-values.yaml
```

The render step in CI and `task render` enumerates these scenarios explicitly. Today:

- `common-app` is a library chart; rendering happens through the fixture at `charts/common-app/examples/render-chart` with `ci/values.yaml`.
- `payloadbox` is rendered with default values and with `ci/ingress-values.yaml`.

Every render is validated with `kubeconform -strict -summary` against Kubernetes `1.32.0` by default. Built-in resources use kubeconform's `default` schema location, and CRDs use Datree's CRDs catalog schema location.

`common-app` README is generated with `helm-docs` from `README.md.gotmpl` and comments in `values.yaml`. Run `task docs` to regenerate, `task docs:check` to verify.
