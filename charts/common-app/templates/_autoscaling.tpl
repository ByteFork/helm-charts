{{- define "common-app.autoscaling" -}}
{{- $autoscaling := default (dict) .Values.autoscaling -}}
{{- $statefulSet := default (dict) .Values.statefulSet -}}
{{- if $autoscaling.enabled -}}
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  {{- include "common-app.metadata" (dict "ctx" . "labels" $autoscaling.labels "annotations" $autoscaling.annotations) | nindent 2 }}
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: {{ ternary "StatefulSet" "Deployment" (eq $statefulSet.enabled true) }}
    name: {{ include "common-app.fullname" . }}
  minReplicas: {{ default 1 $autoscaling.minReplicas }}
  maxReplicas: {{ default 3 $autoscaling.maxReplicas }}
  metrics:
    {{- if $autoscaling.targetCPUUtilizationPercentage }}
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: {{ $autoscaling.targetCPUUtilizationPercentage }}
    {{- end }}
    {{- if $autoscaling.targetMemoryUtilizationPercentage }}
    - type: Resource
      resource:
        name: memory
        target:
          type: Utilization
          averageUtilization: {{ $autoscaling.targetMemoryUtilizationPercentage }}
    {{- end }}
  {{- with $autoscaling.behavior }}
  behavior:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end -}}
{{- end -}}
