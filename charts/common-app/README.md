# common-app

Shared Helm library chart for deploying applications on Kubernetes.

`common-app` is a Helm library chart. It is not installed directly; application charts depend on it and call its named templates.

The library renders one primary application workload per release:

- `Deployment`
- optional `StatefulSet`
- `Service`
- optional `Ingress`
- optional `ConfigMap`
- optional `Secret`
- optional `ServiceAccount`
- optional `HorizontalPodAutoscaler`
- optional `PodDisruptionBudget`
- optional `NetworkPolicy`
- optional `ServiceMonitor`
- optional `PodMonitor`

It also centralizes labels, selectors, probes, environment variables, service account configuration, pod security context, container security context, resources, node selectors, tolerations, affinity, and extra volumes.

## Usage

Add `common-app` as a dependency from the ByteFork chart repository or by local path while developing:

```yaml
dependencies:
  - name: common-app
    version: 0.0.1
    repository: https://bytefork.github.io/helm-charts
```

Then render all supported resources from an application chart template:

```gotemplate
{{ include "common-app.all" . }}
```

Application charts can also include individual templates such as `common-app.deployment`, `common-app.service`, or `common-app.ingress`.

## Render Check

This repository includes a fixture chart at `examples/render-chart` that depends on `common-app` by local path. Use it to verify the library renders valid manifests:

```sh
helm dependency build charts/common-app/examples/render-chart --skip-refresh
helm template common-app-fixture charts/common-app/examples/render-chart \
  --values charts/common-app/examples/render-chart/ci/values.yaml
```

## Values

The library expects application charts to expose the values they want to support. At minimum, consumers must set `image.repository`.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| replicaCount | int | `1` | Number of application replicas. |
| nameOverride | string | `""` | Override the chart name used in resource names. |
| fullnameOverride | string | `""` | Override the full generated resource name. |
| commonLabels | object | `{}` | Labels added to all resources rendered by the library. |
| commonAnnotations | object | `{}` | Annotations added to all resources rendered by the library. |
| serviceAccount | object | `{"annotations":{},"automountServiceAccountToken":false,"create":true,"labels":{},"name":""}` | ServiceAccount configuration for the workload. |
| serviceAccount.create | bool | `true` | Create a ServiceAccount. |
| serviceAccount.name | string | `""` | Name of the ServiceAccount to create or use. Defaults to the chart fullname. |
| serviceAccount.automountServiceAccountToken | bool | `false` | Whether pods should automount the ServiceAccount token. |
| serviceAccount.annotations | object | `{}` | Annotations added to the ServiceAccount. |
| serviceAccount.labels | object | `{}` | Labels added to the ServiceAccount. |
| image | object | `{"pullPolicy":"IfNotPresent","repository":"","tag":""}` | Container image configuration. |
| image.repository | string | `""` | Container image repository. Required by consuming charts. |
| image.tag | string | `""` | Container image tag. Defaults to chart `appVersion` when empty. |
| image.pullPolicy | string | `"IfNotPresent"` | Container image pull policy. |
| imagePullSecrets | list | `[]` | Image pull secrets attached to the pod. |
| deployment | object | `{"annotations":{},"enabled":true,"labels":{}}` | Deployment configuration. |
| deployment.enabled | bool | `true` | Create a Deployment workload. |
| deployment.annotations | object | `{}` | Annotations added to the Deployment. |
| deployment.labels | object | `{}` | Labels added to the Deployment. |
| statefulSet | object | `{"annotations":{},"enabled":false,"labels":{},"podManagementPolicy":"OrderedReady","serviceName":"","updateStrategy":{"type":"RollingUpdate"},"volumeClaimTemplates":[]}` | StatefulSet configuration. Enable instead of Deployment for workloads that require stable identity. |
| statefulSet.enabled | bool | `false` | Create a StatefulSet workload. |
| statefulSet.annotations | object | `{}` | Annotations added to the StatefulSet. |
| statefulSet.labels | object | `{}` | Labels added to the StatefulSet. |
| statefulSet.serviceName | string | `""` | StatefulSet serviceName. Defaults to the chart fullname. |
| statefulSet.podManagementPolicy | string | `"OrderedReady"` | StatefulSet pod management policy. |
| statefulSet.updateStrategy | object | `{"type":"RollingUpdate"}` | StatefulSet update strategy. |
| statefulSet.volumeClaimTemplates | list | `[]` | StatefulSet volume claim templates. |
| podAnnotations | object | `{}` | Annotations added to workload pods. |
| podLabels | object | `{}` | Labels added to workload pods. |
| podSecurityContext | object | `{"runAsNonRoot":true,"seccompProfile":{"type":"RuntimeDefault"}}` | Pod security context. |
| securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":true,"runAsNonRoot":true}` | Container security context. |
| service | object | `{"annotations":{},"enabled":true,"extraPorts":[],"labels":{},"port":80,"protocol":"TCP","targetPort":"http","type":"ClusterIP"}` | Service configuration. |
| service.enabled | bool | `true` | Create a Service. |
| service.type | string | `"ClusterIP"` | Service type. |
| service.port | int | `80` | Service port. |
| service.targetPort | string | `"http"` | Service target port. |
| service.protocol | string | `"TCP"` | Service protocol. |
| service.extraPorts | list | `[]` | Additional Service ports appended after the primary `http` port. Each entry must match the Kubernetes ServicePort shape. |
| service.annotations | object | `{}` | Annotations added to the Service. |
| service.labels | object | `{}` | Labels added to the Service. |
| containerPort | int | `8080` | Primary container HTTP port. |
| extraContainerPorts | list | `[]` | Additional container ports appended after the primary `http` port. Each entry must match the Kubernetes ContainerPort shape. |
| ingress | object | `{"annotations":{},"className":"","enabled":false,"hosts":[],"labels":{},"tls":[]}` | Ingress configuration. |
| ingress.enabled | bool | `false` | Create an Ingress. |
| ingress.className | string | `""` | IngressClass name. |
| ingress.annotations | object | `{}` | Annotations added to the Ingress. |
| ingress.labels | object | `{}` | Labels added to the Ingress. |
| ingress.hosts | list | `[]` | Ingress host rules. |
| ingress.tls | list | `[]` | Ingress TLS configuration. |
| probes | object | `{"liveness":{"enabled":true,"failureThreshold":3,"initialDelaySeconds":10,"path":"/healthz","periodSeconds":10,"timeoutSeconds":2},"readiness":{"enabled":true,"failureThreshold":3,"initialDelaySeconds":5,"path":"/healthz","periodSeconds":10,"timeoutSeconds":2}}` | HTTP probe configuration. |
| probes.liveness | object | `{"enabled":true,"failureThreshold":3,"initialDelaySeconds":10,"path":"/healthz","periodSeconds":10,"timeoutSeconds":2}` | Liveness probe configuration. |
| probes.liveness.enabled | bool | `true` | Enable the liveness probe. |
| probes.liveness.path | string | `"/healthz"` | Liveness probe HTTP path. |
| probes.liveness.initialDelaySeconds | int | `10` | Liveness probe initial delay in seconds. |
| probes.liveness.periodSeconds | int | `10` | Liveness probe period in seconds. |
| probes.liveness.timeoutSeconds | int | `2` | Liveness probe timeout in seconds. |
| probes.liveness.failureThreshold | int | `3` | Liveness probe failure threshold. |
| probes.readiness | object | `{"enabled":true,"failureThreshold":3,"initialDelaySeconds":5,"path":"/healthz","periodSeconds":10,"timeoutSeconds":2}` | Readiness probe configuration. |
| probes.readiness.enabled | bool | `true` | Enable the readiness probe. |
| probes.readiness.path | string | `"/healthz"` | Readiness probe HTTP path. |
| probes.readiness.initialDelaySeconds | int | `5` | Readiness probe initial delay in seconds. |
| probes.readiness.periodSeconds | int | `10` | Readiness probe period in seconds. |
| probes.readiness.timeoutSeconds | int | `2` | Readiness probe timeout in seconds. |
| probes.readiness.failureThreshold | int | `3` | Readiness probe failure threshold. |
| env | list | `[]` | Additional Kubernetes env entries. |
| envMap | object | `{}` | Additional literal environment variables rendered as Kubernetes env entries. |
| envFrom | list | `[]` | Additional envFrom entries. |
| configMap | object | `{"annotations":{},"data":{},"enabled":false,"labels":{},"name":""}` | ConfigMap configuration. |
| configMap.enabled | bool | `false` | Create a ConfigMap. |
| configMap.name | string | `""` | ConfigMap name. Defaults to `<fullname>-config`. |
| configMap.annotations | object | `{}` | Annotations added to the ConfigMap. |
| configMap.labels | object | `{}` | Labels added to the ConfigMap. |
| configMap.data | object | `{}` | ConfigMap data. |
| secret | object | `{"annotations":{},"data":{},"enabled":false,"labels":{},"name":"","stringData":{},"type":"Opaque"}` | Secret configuration. |
| secret.enabled | bool | `false` | Create a Secret. |
| secret.name | string | `""` | Secret name. Defaults to `<fullname>-secret`. |
| secret.type | string | `"Opaque"` | Secret type. |
| secret.annotations | object | `{}` | Annotations added to the Secret. |
| secret.labels | object | `{}` | Labels added to the Secret. |
| secret.data | object | `{}` | Secret data. Values must be base64-encoded. |
| secret.stringData | object | `{}` | Secret stringData. Values are encoded by Kubernetes. |
| serviceMonitor | object | `{"annotations":{},"enabled":false,"honorLabels":false,"interval":"30s","labels":{},"metricRelabelings":[],"namespaceSelector":{},"path":"/metrics","port":"http","relabelings":[],"scheme":"http","scrapeTimeout":"10s","selector":{}}` | Prometheus Operator ServiceMonitor configuration. |
| serviceMonitor.enabled | bool | `false` | Create a ServiceMonitor. |
| serviceMonitor.annotations | object | `{}` | Annotations added to the ServiceMonitor. |
| serviceMonitor.labels | object | `{}` | Labels added to the ServiceMonitor. |
| serviceMonitor.interval | string | `"30s"` | Scrape interval. |
| serviceMonitor.scrapeTimeout | string | `"10s"` | Scrape timeout. |
| serviceMonitor.path | string | `"/metrics"` | Metrics HTTP path. |
| serviceMonitor.port | string | `"http"` | Named service port to scrape. |
| serviceMonitor.scheme | string | `"http"` | Metrics scheme. |
| serviceMonitor.honorLabels | bool | `false` | Honor labels from scraped metrics. |
| serviceMonitor.selector | object | `{}` | Additional selector labels. |
| serviceMonitor.namespaceSelector | object | `{}` | ServiceMonitor namespace selector. |
| serviceMonitor.metricRelabelings | list | `[]` | Metric relabeling rules. |
| serviceMonitor.relabelings | list | `[]` | Relabeling rules. |
| podMonitor | object | `{"annotations":{},"enabled":false,"honorLabels":false,"interval":"30s","labels":{},"metricRelabelings":[],"namespaceSelector":{},"path":"/metrics","port":"http","relabelings":[],"scheme":"http","scrapeTimeout":"10s","selector":{}}` | Prometheus Operator PodMonitor configuration. |
| podMonitor.enabled | bool | `false` | Create a PodMonitor. |
| podMonitor.annotations | object | `{}` | Annotations added to the PodMonitor. |
| podMonitor.labels | object | `{}` | Labels added to the PodMonitor. |
| podMonitor.interval | string | `"30s"` | Scrape interval. |
| podMonitor.scrapeTimeout | string | `"10s"` | Scrape timeout. |
| podMonitor.path | string | `"/metrics"` | Metrics HTTP path. |
| podMonitor.port | string | `"http"` | Named pod port to scrape. |
| podMonitor.scheme | string | `"http"` | Metrics scheme. |
| podMonitor.honorLabels | bool | `false` | Honor labels from scraped metrics. |
| podMonitor.selector | object | `{}` | Additional selector labels. |
| podMonitor.namespaceSelector | object | `{}` | PodMonitor namespace selector. |
| podMonitor.metricRelabelings | list | `[]` | Metric relabeling rules. |
| podMonitor.relabelings | list | `[]` | Relabeling rules. |
| autoscaling | object | `{"annotations":{},"behavior":{},"enabled":false,"labels":{},"maxReplicas":3,"minReplicas":1,"targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":null}` | HorizontalPodAutoscaler configuration. |
| autoscaling.enabled | bool | `false` | Create a HorizontalPodAutoscaler. |
| autoscaling.annotations | object | `{}` | Annotations added to the HorizontalPodAutoscaler. |
| autoscaling.labels | object | `{}` | Labels added to the HorizontalPodAutoscaler. |
| autoscaling.minReplicas | int | `1` | Minimum number of replicas. |
| autoscaling.maxReplicas | int | `3` | Maximum number of replicas. |
| autoscaling.targetCPUUtilizationPercentage | int | `80` | Target average CPU utilization percentage. |
| autoscaling.targetMemoryUtilizationPercentage | string | `nil` | Target average memory utilization percentage. |
| autoscaling.behavior | object | `{}` | HorizontalPodAutoscaler behavior configuration. |
| podDisruptionBudget | object | `{"annotations":{},"enabled":false,"labels":{},"maxUnavailable":null,"minAvailable":1}` | PodDisruptionBudget configuration. |
| podDisruptionBudget.enabled | bool | `false` | Create a PodDisruptionBudget. |
| podDisruptionBudget.annotations | object | `{}` | Annotations added to the PodDisruptionBudget. |
| podDisruptionBudget.labels | object | `{}` | Labels added to the PodDisruptionBudget. |
| podDisruptionBudget.minAvailable | int | `1` | Minimum available pods. |
| podDisruptionBudget.maxUnavailable | string | `nil` | Maximum unavailable pods. Takes precedence over minAvailable when set. |
| networkPolicy | object | `{"annotations":{},"egress":[],"enabled":false,"ingress":[],"labels":{},"podSelector":{},"policyTypes":["Ingress"]}` | NetworkPolicy configuration. |
| networkPolicy.enabled | bool | `false` | Create a NetworkPolicy. |
| networkPolicy.annotations | object | `{}` | Annotations added to the NetworkPolicy. |
| networkPolicy.labels | object | `{}` | Labels added to the NetworkPolicy. |
| networkPolicy.podSelector | object | `{}` | Additional pod selector labels. |
| networkPolicy.policyTypes | list | `["Ingress"]` | NetworkPolicy policy types. |
| networkPolicy.ingress | list | `[]` | NetworkPolicy ingress rules. |
| networkPolicy.egress | list | `[]` | NetworkPolicy egress rules. |
| resources | object | `{}` | Container resource requests and limits. |
| nodeSelector | object | `{}` | Pod node selector. |
| tolerations | list | `[]` | Pod tolerations. |
| affinity | object | `{}` | Pod affinity. |
| extraVolumeMounts | list | `[]` | Additional volume mounts added to the primary container. |
| extraVolumes | list | `[]` | Additional volumes added to the pod. |
