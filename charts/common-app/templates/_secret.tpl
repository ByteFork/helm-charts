{{- define "common-app.secretName" -}}
{{- $secret := default (dict) .Values.secret -}}
{{- default (printf "%s-secret" (include "common-app.fullname" .)) $secret.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "common-app.secret" -}}
{{- $secret := default (dict) .Values.secret -}}
{{- if or $secret.enabled $secret.data $secret.stringData -}}
apiVersion: v1
kind: Secret
metadata:
  {{- include "common-app.metadata" (dict "ctx" . "name" (include "common-app.secretName" .) "labels" $secret.labels "annotations" $secret.annotations) | nindent 2 }}
type: {{ default "Opaque" $secret.type }}
{{- with $secret.data }}
data:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- with $secret.stringData }}
stringData:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end -}}
{{- end -}}
