{{/*
Expand the name of the chart.
*/}}
{{- define "common-app.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "common-app.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "common-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels.
*/}}
{{- define "common-app.labels" -}}
helm.sh/chart: {{ include "common-app.chart" . }}
{{ include "common-app.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Values.commonLabels }}
{{ toYaml . }}
{{- end }}
{{- end -}}

{{/*
Selector labels.
*/}}
{{- define "common-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "common-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Service account name.
*/}}
{{- define "common-app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- default (include "common-app.fullname" .) .Values.serviceAccount.name -}}
{{- else -}}
{{- default "default" .Values.serviceAccount.name -}}
{{- end -}}
{{- end -}}

{{/*
ConfigMap name.
*/}}
{{- define "common-app.configMapName" -}}
{{- default (printf "%s-config" (include "common-app.fullname" .)) .Values.configMap.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Container image.
*/}}
{{- define "common-app.image" -}}
{{- $tag := default .Chart.AppVersion .Values.image.tag -}}
{{- if not .Values.image.repository -}}
{{- fail "image.repository is required" -}}
{{- end -}}
{{- printf "%s:%s" .Values.image.repository $tag -}}
{{- end -}}

{{/*
Render metadata.name + metadata.labels + metadata.annotations for a chart resource.
Combines common-app labels and commonAnnotations with optional per-resource overrides.
Defaults the name to common-app.fullname; pass `name` to override (e.g. ServiceAccount, Secret, ConfigMap).

Usage:
  metadata:
    {{- include "common-app.metadata" (dict "ctx" . "labels" .Values.foo.labels "annotations" .Values.foo.annotations) | nindent 2 }}

  metadata:
    {{- include "common-app.metadata" (dict "ctx" . "name" (include "common-app.secretName" .) "labels" $secret.labels "annotations" $secret.annotations) | nindent 2 }}
*/}}
{{- define "common-app.metadata" -}}
name: {{ default (include "common-app.fullname" .ctx) .name }}
labels:
  {{- include "common-app.labels" .ctx | nindent 2 }}
  {{- with .labels }}
  {{- toYaml . | nindent 2 }}
  {{- end }}
{{- $common := default (dict) .ctx.Values.commonAnnotations -}}
{{- $extra := default (dict) .annotations -}}
{{- $annotations := mergeOverwrite (deepCopy $common) $extra }}
{{- with $annotations }}
annotations:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end -}}

{{/*
Render a Prometheus Operator monitor (ServiceMonitor or PodMonitor).
Both kinds share the same shape; only the resource kind and the endpoints
field name differ. Wrappers in _servicemonitor.tpl and _podmonitor.tpl
supply the right parameters.

Required dict args:
  ctx             chart context (`.`)
  key             values key, e.g. "serviceMonitor"
  kind            resource kind, e.g. "ServiceMonitor"
  endpointsField  spec field name, "endpoints" or "podMetricsEndpoints"
*/}}
{{- define "common-app.monitor" -}}
{{- $monitor := default (dict) (index .ctx.Values .key) -}}
{{- if $monitor.enabled -}}
apiVersion: monitoring.coreos.com/v1
kind: {{ .kind }}
metadata:
  {{- include "common-app.metadata" (dict "ctx" .ctx "labels" $monitor.labels "annotations" $monitor.annotations) | nindent 2 }}
spec:
  selector:
    matchLabels:
      {{- include "common-app.selectorLabels" .ctx | nindent 6 }}
      {{- with $monitor.selector }}
      {{- toYaml . | nindent 6 }}
      {{- end }}
  {{- with $monitor.namespaceSelector }}
  namespaceSelector:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{ .endpointsField }}:
    - port: {{ default "http" $monitor.port }}
      path: {{ default "/metrics" $monitor.path }}
      scheme: {{ default "http" $monitor.scheme }}
      interval: {{ default "30s" $monitor.interval }}
      scrapeTimeout: {{ default "10s" $monitor.scrapeTimeout }}
      honorLabels: {{ default false $monitor.honorLabels }}
      {{- with $monitor.metricRelabelings }}
      metricRelabelings:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with $monitor.relabelings }}
      relabelings:
        {{- toYaml . | nindent 8 }}
      {{- end }}
{{- end -}}
{{- end -}}

{{/*
Validate value combinations. Called from common-app.all.
*/}}
{{- define "common-app.validate" -}}
{{- $deployment := default (dict) .Values.deployment -}}
{{- $statefulSet := default (dict) .Values.statefulSet -}}
{{- if and $deployment.enabled $statefulSet.enabled -}}
{{- fail "deployment.enabled and statefulSet.enabled are mutually exclusive: enable one workload, not both" -}}
{{- end -}}
{{- end -}}

{{/*
Render a map of environment variables as EnvVar items.
*/}}
{{- define "common-app.envMap" -}}
{{- range $name, $value := .Values.envMap }}
- name: {{ $name }}
  value: {{ $value | quote }}
{{- end }}
{{- end -}}

{{/*
Render all container environment variables as EnvVar items.
*/}}
{{- define "common-app.env" -}}
{{- with .Values.env }}
{{ toYaml . }}
{{- end }}
{{- include "common-app.envMap" . }}
{{- end -}}
