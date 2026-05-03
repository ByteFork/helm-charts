{{- define "common-app.deployment" -}}
{{- if .Values.deployment.enabled -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  {{- include "common-app.metadata" (dict "ctx" . "labels" .Values.deployment.labels "annotations" .Values.deployment.annotations) | nindent 2 }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      {{- include "common-app.selectorLabels" . | nindent 6 }}
  template:
    {{- include "common-app.podMetadata" . | nindent 4 }}
    {{- include "common-app.podSpec" . | nindent 4 }}
{{- end -}}
{{- end -}}
