{{- define "common-app.statefulSet" -}}
{{- $statefulSet := default (dict) .Values.statefulSet -}}
{{- if $statefulSet.enabled -}}
apiVersion: apps/v1
kind: StatefulSet
metadata:
  {{- include "common-app.metadata" (dict "ctx" . "labels" $statefulSet.labels "annotations" $statefulSet.annotations) | nindent 2 }}
spec:
  serviceName: {{ default (include "common-app.fullname" .) $statefulSet.serviceName }}
  replicas: {{ .Values.replicaCount }}
  podManagementPolicy: {{ default "OrderedReady" $statefulSet.podManagementPolicy }}
  updateStrategy:
    {{- toYaml (default (dict "type" "RollingUpdate") $statefulSet.updateStrategy) | nindent 4 }}
  selector:
    matchLabels:
      {{- include "common-app.selectorLabels" . | nindent 6 }}
  template:
    {{- include "common-app.podMetadata" . | nindent 4 }}
    {{- include "common-app.podSpec" . | nindent 4 }}
  {{- with $statefulSet.volumeClaimTemplates }}
  volumeClaimTemplates:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end -}}
{{- end -}}
