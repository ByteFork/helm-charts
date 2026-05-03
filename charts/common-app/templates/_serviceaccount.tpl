{{- define "common-app.serviceAccount" -}}
{{- if .Values.serviceAccount.create -}}
apiVersion: v1
kind: ServiceAccount
metadata:
  {{- include "common-app.metadata" (dict "ctx" . "name" (include "common-app.serviceAccountName" .) "labels" .Values.serviceAccount.labels "annotations" .Values.serviceAccount.annotations) | nindent 2 }}
automountServiceAccountToken: {{ .Values.serviceAccount.automountServiceAccountToken }}
{{- end -}}
{{- end -}}
