{{- define "common-app.serviceMonitor" -}}
{{- include "common-app.monitor" (dict "ctx" . "key" "serviceMonitor" "kind" "ServiceMonitor" "endpointsField" "endpoints") -}}
{{- end -}}
