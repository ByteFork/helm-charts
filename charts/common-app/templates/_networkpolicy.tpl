{{- define "common-app.networkPolicy" -}}
{{- $networkPolicy := default (dict) .Values.networkPolicy -}}
{{- if $networkPolicy.enabled -}}
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  {{- include "common-app.metadata" (dict "ctx" . "labels" $networkPolicy.labels "annotations" $networkPolicy.annotations) | nindent 2 }}
spec:
  podSelector:
    matchLabels:
      {{- include "common-app.selectorLabels" . | nindent 6 }}
      {{- with $networkPolicy.podSelector }}
      {{- toYaml . | nindent 6 }}
      {{- end }}
  policyTypes:
    {{- toYaml (default (list "Ingress") $networkPolicy.policyTypes) | nindent 4 }}
  {{- with $networkPolicy.ingress }}
  ingress:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with $networkPolicy.egress }}
  egress:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end -}}
{{- end -}}
