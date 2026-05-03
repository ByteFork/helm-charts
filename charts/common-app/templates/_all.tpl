{{- define "common-app.all" -}}
{{- include "common-app.validate" . -}}
{{- $resources := list
  (include "common-app.serviceAccount" .)
  (include "common-app.configMap" .)
  (include "common-app.secret" .)
  (include "common-app.service" .)
  (include "common-app.ingress" .)
  (include "common-app.deployment" .)
  (include "common-app.statefulSet" .)
  (include "common-app.autoscaling" .)
  (include "common-app.podDisruptionBudget" .)
  (include "common-app.networkPolicy" .)
  (include "common-app.serviceMonitor" .)
  (include "common-app.podMonitor" .)
-}}
{{- range $resource := $resources }}
{{- if $resource }}
---
{{ $resource }}
{{- end }}
{{- end }}
{{- end -}}
