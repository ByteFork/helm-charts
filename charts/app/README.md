# app

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.0.1](https://img.shields.io/badge/AppVersion-0.0.1-informational?style=flat-square)

Generic installable application chart backed by the common-app library. Deploy any container with a Deployment or StatefulSet, Service, Ingress, probes, monitors, autoscaling, and network policies through values alone.

**Homepage:** <https://github.com/ByteFork/helm-charts>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| ByteFork | <helm@bytefork.io> | <https://github.com/ByteFork> |

## Source Code

* <https://github.com/ByteFork/helm-charts>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://bytefork.github.io/helm-charts | common-app | 0.0.1 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Pod affinity. |
| autoscaling | object | `{"annotations":{},"behavior":{},"enabled":false,"labels":{},"maxReplicas":3,"minReplicas":1,"targetCPUUtilizationPercentage":80,"targetMemoryUtilizationPercentage":null}` | HorizontalPodAutoscaler configuration. |
| autoscaling.annotations | object | `{}` | Annotations added to the HorizontalPodAutoscaler. |
| autoscaling.behavior | object | `{}` | HorizontalPodAutoscaler behavior configuration. |
| autoscaling.enabled | bool | `false` | Create a HorizontalPodAutoscaler. |
| autoscaling.labels | object | `{}` | Labels added to the HorizontalPodAutoscaler. |
| autoscaling.maxReplicas | int | `3` | Maximum number of replicas. |
| autoscaling.minReplicas | int | `1` | Minimum number of replicas. |
| autoscaling.targetCPUUtilizationPercentage | int | `80` | Target average CPU utilization percentage. |
| autoscaling.targetMemoryUtilizationPercentage | string | `nil` | Target average memory utilization percentage. |
| commonAnnotations | object | `{}` | Annotations added to all resources rendered by the library. |
| commonLabels | object | `{}` | Labels added to all resources rendered by the library. |
| configMap | object | `{"annotations":{},"data":{},"enabled":false,"labels":{},"name":""}` | ConfigMap configuration. |
| configMap.annotations | object | `{}` | Annotations added to the ConfigMap. |
| configMap.data | object | `{}` | ConfigMap data. |
| configMap.enabled | bool | `false` | Create a ConfigMap. |
| configMap.labels | object | `{}` | Labels added to the ConfigMap. |
| configMap.name | string | `""` | ConfigMap name. Defaults to `<fullname>-config`. |
| containerPort | int | `8080` | Primary container HTTP port. |
| deployment | object | `{"annotations":{},"enabled":true,"labels":{}}` | Deployment configuration. |
| deployment.annotations | object | `{}` | Annotations added to the Deployment. |
| deployment.enabled | bool | `true` | Create a Deployment workload. |
| deployment.labels | object | `{}` | Labels added to the Deployment. |
| env | list | `[]` | Additional Kubernetes env entries. |
| envFrom | list | `[]` | Additional envFrom entries. |
| envMap | object | `{}` | Additional literal environment variables rendered as Kubernetes env entries. |
| extraContainerPorts | list | `[]` | Additional container ports appended after the primary `http` port. Each entry must match the Kubernetes ContainerPort shape. |
| extraVolumeMounts | list | `[]` | Additional volume mounts added to the primary container. |
| extraVolumes | list | `[]` | Additional volumes added to the pod. |
| fullnameOverride | string | `""` | Override the full generated resource name. |
| image | object | `{"pullPolicy":"IfNotPresent","repository":"","tag":""}` | Container image configuration. |
| image.pullPolicy | string | `"IfNotPresent"` | Container image pull policy. |
| image.repository | string | `""` | Container image repository. Required by consuming charts. |
| image.tag | string | `""` | Container image tag. Defaults to chart `appVersion` when empty. |
| imagePullSecrets | list | `[]` | Image pull secrets attached to the pod. |
| ingress | object | `{"annotations":{},"className":"","enabled":false,"hosts":[],"labels":{},"tls":[]}` | Ingress configuration. |
| ingress.annotations | object | `{}` | Annotations added to the Ingress. |
| ingress.className | string | `""` | IngressClass name. |
| ingress.enabled | bool | `false` | Create an Ingress. |
| ingress.hosts | list | `[]` | Ingress host rules. |
| ingress.labels | object | `{}` | Labels added to the Ingress. |
| ingress.tls | list | `[]` | Ingress TLS configuration. |
| nameOverride | string | `""` | Override the chart name used in resource names. |
| networkPolicy | object | `{"annotations":{},"egress":[],"enabled":false,"ingress":[],"labels":{},"podSelector":{},"policyTypes":["Ingress"]}` | NetworkPolicy configuration. |
| networkPolicy.annotations | object | `{}` | Annotations added to the NetworkPolicy. |
| networkPolicy.egress | list | `[]` | NetworkPolicy egress rules. |
| networkPolicy.enabled | bool | `false` | Create a NetworkPolicy. |
| networkPolicy.ingress | list | `[]` | NetworkPolicy ingress rules. |
| networkPolicy.labels | object | `{}` | Labels added to the NetworkPolicy. |
| networkPolicy.podSelector | object | `{}` | Additional pod selector labels. |
| networkPolicy.policyTypes | list | `["Ingress"]` | NetworkPolicy policy types. |
| nodeSelector | object | `{}` | Pod node selector. |
| podAnnotations | object | `{}` | Annotations added to workload pods. |
| podDisruptionBudget | object | `{"annotations":{},"enabled":false,"labels":{},"maxUnavailable":null,"minAvailable":1}` | PodDisruptionBudget configuration. |
| podDisruptionBudget.annotations | object | `{}` | Annotations added to the PodDisruptionBudget. |
| podDisruptionBudget.enabled | bool | `false` | Create a PodDisruptionBudget. |
| podDisruptionBudget.labels | object | `{}` | Labels added to the PodDisruptionBudget. |
| podDisruptionBudget.maxUnavailable | string | `nil` | Maximum unavailable pods. Takes precedence over minAvailable when set. |
| podDisruptionBudget.minAvailable | int | `1` | Minimum available pods. |
| podLabels | object | `{}` | Labels added to workload pods. |
| podMonitor | object | `{"annotations":{},"enabled":false,"honorLabels":false,"interval":"30s","labels":{},"metricRelabelings":[],"namespaceSelector":{},"path":"/metrics","port":"http","relabelings":[],"scheme":"http","scrapeTimeout":"10s","selector":{}}` | Prometheus Operator PodMonitor configuration. |
| podMonitor.annotations | object | `{}` | Annotations added to the PodMonitor. |
| podMonitor.enabled | bool | `false` | Create a PodMonitor. |
| podMonitor.honorLabels | bool | `false` | Honor labels from scraped metrics. |
| podMonitor.interval | string | `"30s"` | Scrape interval. |
| podMonitor.labels | object | `{}` | Labels added to the PodMonitor. |
| podMonitor.metricRelabelings | list | `[]` | Metric relabeling rules. |
| podMonitor.namespaceSelector | object | `{}` | PodMonitor namespace selector. |
| podMonitor.path | string | `"/metrics"` | Metrics HTTP path. |
| podMonitor.port | string | `"http"` | Named pod port to scrape. |
| podMonitor.relabelings | list | `[]` | Relabeling rules. |
| podMonitor.scheme | string | `"http"` | Metrics scheme. |
| podMonitor.scrapeTimeout | string | `"10s"` | Scrape timeout. |
| podMonitor.selector | object | `{}` | Additional selector labels. |
| podSecurityContext | object | `{"runAsNonRoot":true,"seccompProfile":{"type":"RuntimeDefault"}}` | Pod security context. |
| probes | object | `{"liveness":{"enabled":true,"failureThreshold":3,"initialDelaySeconds":10,"path":"/healthz","periodSeconds":10,"timeoutSeconds":2},"readiness":{"enabled":true,"failureThreshold":3,"initialDelaySeconds":5,"path":"/healthz","periodSeconds":10,"timeoutSeconds":2}}` | HTTP probe configuration. |
| probes.liveness | object | `{"enabled":true,"failureThreshold":3,"initialDelaySeconds":10,"path":"/healthz","periodSeconds":10,"timeoutSeconds":2}` | Liveness probe configuration. |
| probes.liveness.enabled | bool | `true` | Enable the liveness probe. |
| probes.liveness.failureThreshold | int | `3` | Liveness probe failure threshold. |
| probes.liveness.initialDelaySeconds | int | `10` | Liveness probe initial delay in seconds. |
| probes.liveness.path | string | `"/healthz"` | Liveness probe HTTP path. |
| probes.liveness.periodSeconds | int | `10` | Liveness probe period in seconds. |
| probes.liveness.timeoutSeconds | int | `2` | Liveness probe timeout in seconds. |
| probes.readiness | object | `{"enabled":true,"failureThreshold":3,"initialDelaySeconds":5,"path":"/healthz","periodSeconds":10,"timeoutSeconds":2}` | Readiness probe configuration. |
| probes.readiness.enabled | bool | `true` | Enable the readiness probe. |
| probes.readiness.failureThreshold | int | `3` | Readiness probe failure threshold. |
| probes.readiness.initialDelaySeconds | int | `5` | Readiness probe initial delay in seconds. |
| probes.readiness.path | string | `"/healthz"` | Readiness probe HTTP path. |
| probes.readiness.periodSeconds | int | `10` | Readiness probe period in seconds. |
| probes.readiness.timeoutSeconds | int | `2` | Readiness probe timeout in seconds. |
| replicaCount | int | `1` | Number of application replicas. |
| resources | object | `{}` | Container resource requests and limits. |
| secret | object | `{"annotations":{},"data":{},"enabled":false,"labels":{},"name":"","stringData":{},"type":"Opaque"}` | Secret configuration. |
| secret.annotations | object | `{}` | Annotations added to the Secret. |
| secret.data | object | `{}` | Secret data. Values must be base64-encoded. |
| secret.enabled | bool | `false` | Create a Secret. |
| secret.labels | object | `{}` | Labels added to the Secret. |
| secret.name | string | `""` | Secret name. Defaults to `<fullname>-secret`. |
| secret.stringData | object | `{}` | Secret stringData. Values are encoded by Kubernetes. |
| secret.type | string | `"Opaque"` | Secret type. |
| securityContext | object | `{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":true,"runAsNonRoot":true}` | Container security context. |
| service | object | `{"annotations":{},"enabled":true,"extraPorts":[],"labels":{},"port":80,"protocol":"TCP","targetPort":"http","type":"ClusterIP"}` | Service configuration. |
| service.annotations | object | `{}` | Annotations added to the Service. |
| service.enabled | bool | `true` | Create a Service. |
| service.extraPorts | list | `[]` | Additional Service ports appended after the primary `http` port. Each entry must match the Kubernetes ServicePort shape. |
| service.labels | object | `{}` | Labels added to the Service. |
| service.port | int | `80` | Service port. |
| service.protocol | string | `"TCP"` | Service protocol. |
| service.targetPort | string | `"http"` | Service target port. |
| service.type | string | `"ClusterIP"` | Service type. |
| serviceAccount | object | `{"annotations":{},"automountServiceAccountToken":false,"create":true,"labels":{},"name":""}` | ServiceAccount configuration for the workload. |
| serviceAccount.annotations | object | `{}` | Annotations added to the ServiceAccount. |
| serviceAccount.automountServiceAccountToken | bool | `false` | Whether pods should automount the ServiceAccount token. |
| serviceAccount.create | bool | `true` | Create a ServiceAccount. |
| serviceAccount.labels | object | `{}` | Labels added to the ServiceAccount. |
| serviceAccount.name | string | `""` | Name of the ServiceAccount to create or use. Defaults to the chart fullname. |
| serviceMonitor | object | `{"annotations":{},"enabled":false,"honorLabels":false,"interval":"30s","labels":{},"metricRelabelings":[],"namespaceSelector":{},"path":"/metrics","port":"http","relabelings":[],"scheme":"http","scrapeTimeout":"10s","selector":{}}` | Prometheus Operator ServiceMonitor configuration. |
| serviceMonitor.annotations | object | `{}` | Annotations added to the ServiceMonitor. |
| serviceMonitor.enabled | bool | `false` | Create a ServiceMonitor. |
| serviceMonitor.honorLabels | bool | `false` | Honor labels from scraped metrics. |
| serviceMonitor.interval | string | `"30s"` | Scrape interval. |
| serviceMonitor.labels | object | `{}` | Labels added to the ServiceMonitor. |
| serviceMonitor.metricRelabelings | list | `[]` | Metric relabeling rules. |
| serviceMonitor.namespaceSelector | object | `{}` | ServiceMonitor namespace selector. |
| serviceMonitor.path | string | `"/metrics"` | Metrics HTTP path. |
| serviceMonitor.port | string | `"http"` | Named service port to scrape. |
| serviceMonitor.relabelings | list | `[]` | Relabeling rules. |
| serviceMonitor.scheme | string | `"http"` | Metrics scheme. |
| serviceMonitor.scrapeTimeout | string | `"10s"` | Scrape timeout. |
| serviceMonitor.selector | object | `{}` | Additional selector labels. |
| statefulSet | object | `{"annotations":{},"enabled":false,"labels":{},"podManagementPolicy":"OrderedReady","serviceName":"","updateStrategy":{"type":"RollingUpdate"},"volumeClaimTemplates":[]}` | StatefulSet configuration. Enable instead of Deployment for workloads that require stable identity. |
| statefulSet.annotations | object | `{}` | Annotations added to the StatefulSet. |
| statefulSet.enabled | bool | `false` | Create a StatefulSet workload. |
| statefulSet.labels | object | `{}` | Labels added to the StatefulSet. |
| statefulSet.podManagementPolicy | string | `"OrderedReady"` | StatefulSet pod management policy. |
| statefulSet.serviceName | string | `""` | StatefulSet serviceName. Defaults to the chart fullname. |
| statefulSet.updateStrategy | object | `{"type":"RollingUpdate"}` | StatefulSet update strategy. |
| statefulSet.volumeClaimTemplates | list | `[]` | StatefulSet volume claim templates. |
| tolerations | list | `[]` | Pod tolerations. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
