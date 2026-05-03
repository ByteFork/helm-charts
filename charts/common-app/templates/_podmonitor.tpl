{{- define "common-app.podMonitor" -}}
{{- include "common-app.monitor" (dict "ctx" . "key" "podMonitor" "kind" "PodMonitor" "endpointsField" "podMetricsEndpoints") -}}
{{- end -}}
