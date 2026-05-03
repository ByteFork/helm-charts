{{- define "common-app.service" -}}
{{- if .Values.service.enabled -}}
apiVersion: v1
kind: Service
metadata:
  {{- include "common-app.metadata" (dict "ctx" . "labels" .Values.service.labels "annotations" .Values.service.annotations) | nindent 2 }}
spec:
  type: {{ .Values.service.type }}
  ports:
    - port: {{ .Values.service.port }}
      targetPort: {{ .Values.service.targetPort }}
      protocol: {{ .Values.service.protocol }}
      name: http
    {{- with .Values.service.extraPorts }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
  selector:
    {{- include "common-app.selectorLabels" . | nindent 4 }}
{{- end -}}
{{- end -}}
