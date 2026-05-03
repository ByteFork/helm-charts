{{- define "common-app.configMap" -}}
{{- if or .Values.configMap.enabled .Values.configMap.data -}}
apiVersion: v1
kind: ConfigMap
metadata:
  {{- include "common-app.metadata" (dict "ctx" . "name" (include "common-app.configMapName" .) "labels" .Values.configMap.labels "annotations" .Values.configMap.annotations) | nindent 2 }}
data:
  {{- range $key, $value := .Values.configMap.data }}
  {{ $key }}: {{ $value | quote }}
  {{- end }}
{{- end -}}
{{- end -}}
