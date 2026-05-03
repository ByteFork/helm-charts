# payloadbox

![Version: 0.0.1](https://img.shields.io/badge/Version-0.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.0.4](https://img.shields.io/badge/AppVersion-0.0.4-informational?style=flat-square)

A Helm chart for PayloadBox.

**Homepage:** <https://github.com/ByteFork/helm-charts>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| ByteFork |  | <https://github.com/ByteFork> |

## Source Code

* <https://github.com/ByteFork/helm-charts>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../common-app | common-app | 0.0.1 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| replicaCount | int | `1` |  |
| nameOverride | string | `""` |  |
| fullnameOverride | string | `""` |  |
| commonLabels | object | `{}` |  |
| commonAnnotations | object | `{}` |  |
| image.repository | string | `"ghcr.io/bytefork/payloadbox"` |  |
| image.tag | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| imagePullSecrets | list | `[]` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| serviceAccount.automountServiceAccountToken | bool | `false` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.labels | object | `{}` |  |
| deployment.enabled | bool | `true` |  |
| deployment.annotations | object | `{}` |  |
| deployment.labels | object | `{}` |  |
| statefulSet.enabled | bool | `false` |  |
| statefulSet.annotations | object | `{}` |  |
| statefulSet.labels | object | `{}` |  |
| statefulSet.serviceName | string | `""` |  |
| statefulSet.podManagementPolicy | string | `"OrderedReady"` |  |
| statefulSet.updateStrategy.type | string | `"RollingUpdate"` |  |
| statefulSet.volumeClaimTemplates | list | `[]` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| securityContext.allowPrivilegeEscalation | bool | `false` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.readOnlyRootFilesystem | bool | `true` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| containerPort | int | `8080` |  |
| extraContainerPorts | list | `[]` |  |
| service.enabled | bool | `true` |  |
| service.type | string | `"ClusterIP"` |  |
| service.port | int | `8080` |  |
| service.targetPort | string | `"http"` |  |
| service.protocol | string | `"TCP"` |  |
| service.extraPorts | list | `[]` |  |
| service.annotations | object | `{}` |  |
| service.labels | object | `{}` |  |
| ingress.enabled | bool | `false` |  |
| ingress.className | string | `""` |  |
| ingress.annotations | object | `{}` |  |
| ingress.labels | object | `{}` |  |
| ingress.hosts | list | `[]` |  |
| ingress.tls | list | `[]` |  |
| probes.liveness.enabled | bool | `true` |  |
| probes.liveness.path | string | `"/healthz"` |  |
| probes.liveness.initialDelaySeconds | int | `10` |  |
| probes.liveness.periodSeconds | int | `10` |  |
| probes.liveness.timeoutSeconds | int | `2` |  |
| probes.liveness.failureThreshold | int | `3` |  |
| probes.readiness.enabled | bool | `true` |  |
| probes.readiness.path | string | `"/healthz"` |  |
| probes.readiness.initialDelaySeconds | int | `5` |  |
| probes.readiness.periodSeconds | int | `10` |  |
| probes.readiness.timeoutSeconds | int | `2` |  |
| probes.readiness.failureThreshold | int | `3` |  |
| payloadbox.maxBodySizeBytes | int | `1048576` |  |
| payloadbox.maxRecordsToStore | int | `1000` |  |
| payloadbox.logHttpRequests | bool | `true` |  |
| payloadbox.logLevel | string | `"info"` |  |
| extraEnv | list | `[]` |  |
| extraEnvMap | object | `{}` |  |
| envFrom | list | `[]` |  |
| configMap.enabled | bool | `false` |  |
| configMap.name | string | `""` |  |
| configMap.annotations | object | `{}` |  |
| configMap.labels | object | `{}` |  |
| configMap.data | object | `{}` |  |
| secret.enabled | bool | `false` |  |
| secret.name | string | `""` |  |
| secret.type | string | `"Opaque"` |  |
| secret.annotations | object | `{}` |  |
| secret.labels | object | `{}` |  |
| secret.data | object | `{}` |  |
| secret.stringData | object | `{}` |  |
| serviceMonitor.enabled | bool | `false` |  |
| serviceMonitor.annotations | object | `{}` |  |
| serviceMonitor.labels | object | `{}` |  |
| serviceMonitor.interval | string | `"30s"` |  |
| serviceMonitor.scrapeTimeout | string | `"10s"` |  |
| serviceMonitor.path | string | `"/metrics"` |  |
| serviceMonitor.port | string | `"http"` |  |
| serviceMonitor.scheme | string | `"http"` |  |
| serviceMonitor.honorLabels | bool | `false` |  |
| serviceMonitor.selector | object | `{}` |  |
| serviceMonitor.namespaceSelector | object | `{}` |  |
| serviceMonitor.metricRelabelings | list | `[]` |  |
| serviceMonitor.relabelings | list | `[]` |  |
| podMonitor.enabled | bool | `false` |  |
| podMonitor.annotations | object | `{}` |  |
| podMonitor.labels | object | `{}` |  |
| podMonitor.interval | string | `"30s"` |  |
| podMonitor.scrapeTimeout | string | `"10s"` |  |
| podMonitor.path | string | `"/metrics"` |  |
| podMonitor.port | string | `"http"` |  |
| podMonitor.scheme | string | `"http"` |  |
| podMonitor.honorLabels | bool | `false` |  |
| podMonitor.selector | object | `{}` |  |
| podMonitor.namespaceSelector | object | `{}` |  |
| podMonitor.metricRelabelings | list | `[]` |  |
| podMonitor.relabelings | list | `[]` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.annotations | object | `{}` |  |
| autoscaling.labels | object | `{}` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.maxReplicas | int | `3` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| autoscaling.targetMemoryUtilizationPercentage | string | `nil` |  |
| autoscaling.behavior | object | `{}` |  |
| podDisruptionBudget.enabled | bool | `false` |  |
| podDisruptionBudget.annotations | object | `{}` |  |
| podDisruptionBudget.labels | object | `{}` |  |
| podDisruptionBudget.minAvailable | int | `1` |  |
| podDisruptionBudget.maxUnavailable | string | `nil` |  |
| networkPolicy.enabled | bool | `false` |  |
| networkPolicy.annotations | object | `{}` |  |
| networkPolicy.labels | object | `{}` |  |
| networkPolicy.podSelector | object | `{}` |  |
| networkPolicy.policyTypes[0] | string | `"Ingress"` |  |
| networkPolicy.ingress | list | `[]` |  |
| networkPolicy.egress | list | `[]` |  |
| resources | object | `{}` |  |
| nodeSelector | object | `{}` |  |
| tolerations | list | `[]` |  |
| affinity | object | `{}` |  |
| extraVolumeMounts | list | `[]` |  |
| extraVolumes | list | `[]` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
