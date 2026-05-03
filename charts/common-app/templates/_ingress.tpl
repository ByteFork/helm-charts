{{- define "common-app.ingress" -}}
{{- if .Values.ingress.enabled -}}
{{- $fullName := include "common-app.fullname" . -}}
{{- $servicePort := .Values.service.port -}}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  {{- include "common-app.metadata" (dict "ctx" . "labels" .Values.ingress.labels "annotations" .Values.ingress.annotations) | nindent 2 }}
spec:
  {{- with .Values.ingress.className }}
  ingressClassName: {{ . }}
  {{- end }}
  {{- with .Values.ingress.tls }}
  tls:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  rules:
    {{- range .Values.ingress.hosts }}
    - host: {{ .host | quote }}
      http:
        paths:
          {{- range .paths }}
          - path: {{ .path }}
            pathType: {{ default "Prefix" .pathType }}
            backend:
              service:
                name: {{ $fullName }}
                port:
                  number: {{ $servicePort }}
          {{- end }}
    {{- end }}
{{- end -}}
{{- end -}}
