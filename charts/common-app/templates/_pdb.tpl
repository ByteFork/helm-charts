{{- define "common-app.podDisruptionBudget" -}}
{{- $pdb := default (dict) .Values.podDisruptionBudget -}}
{{- if $pdb.enabled -}}
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  {{- include "common-app.metadata" (dict "ctx" . "labels" $pdb.labels "annotations" $pdb.annotations) | nindent 2 }}
spec:
  {{- if $pdb.maxUnavailable }}
  maxUnavailable: {{ $pdb.maxUnavailable }}
  {{- else }}
  minAvailable: {{ default 1 $pdb.minAvailable }}
  {{- end }}
  selector:
    matchLabels:
      {{- include "common-app.selectorLabels" . | nindent 6 }}
{{- end -}}
{{- end -}}
