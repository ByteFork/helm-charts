# ByteFork Helm Charts

<div align="center" markdown="1">

![Hero](https://raw.githubusercontent.com/ByteFork/helm-charts/main/docs/assets/helm-charts-hero.svg)
Helm charts published by ByteFork.

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/bytefork)](https://artifacthub.io/packages/search?repo=bytefork)
[![Release](https://github.com/ByteFork/helm-charts/actions/workflows/release.yaml/badge.svg)](https://github.com/ByteFork/helm-charts/actions/workflows/release.yaml)

</div>

## Usage

[Helm](https://helm.sh) must be installed to use the charts. See Helm's [documentation](https://helm.sh/docs/) to get started.

Add the repository:

```console
helm repo add bytefork https://bytefork.github.io/helm-charts
helm repo update
```

Then `helm search repo bytefork` to list available charts.

<!-- Keep full URL links to repo files; this README syncs from main to gh-pages where relative paths do not resolve. -->

## Charts

| Chart | Type | Description |
| --- | --- | --- |
| [payloadbox](https://github.com/ByteFork/helm-charts/blob/main/charts/payloadbox/README.md) | application | PayloadBox HTTP request capture and inspection. |
| [common-app](https://github.com/ByteFork/helm-charts/blob/main/charts/common-app/README.md) | library | Shared library chart used by ByteFork application charts. |

## Contributing

<!-- Keep full URL links to repo files; this README syncs from main to gh-pages. -->

Contributions welcome. See the [contribution guidelines](https://github.com/ByteFork/helm-charts/blob/main/CONTRIBUTING.md) for the local workflow, chart conventions, and release process.

## License

<!-- Keep full URL links to repo files; this README syncs from main to gh-pages. -->

[MIT License](https://github.com/ByteFork/helm-charts/blob/main/LICENSE).
