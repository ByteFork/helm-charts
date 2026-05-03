{{- define "common-app.podMetadata" -}}
metadata:
  labels:
    {{- include "common-app.selectorLabels" . | nindent 4 }}
    {{- with .Values.podLabels }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
  {{- with (mergeOverwrite (deepCopy .Values.commonAnnotations) .Values.podAnnotations) }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end -}}

{{- define "common-app.podSpec" -}}
spec:
  serviceAccountName: {{ include "common-app.serviceAccountName" . }}
  automountServiceAccountToken: {{ .Values.serviceAccount.automountServiceAccountToken }}
  {{- with .Values.imagePullSecrets }}
  imagePullSecrets:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .Values.podSecurityContext }}
  securityContext:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  containers:
    - name: {{ include "common-app.name" . }}
      image: {{ include "common-app.image" . | quote }}
      imagePullPolicy: {{ .Values.image.pullPolicy }}
      ports:
        - name: http
          containerPort: {{ .Values.containerPort }}
          protocol: TCP
        {{- with .Values.extraContainerPorts }}
        {{- toYaml . | nindent 8 }}
        {{- end }}
      {{- $env := include "common-app.env" . }}
      {{- if $env }}
      env:
        {{- $env | trim | nindent 8 }}
      {{- end }}
      {{- with .Values.envFrom }}
      envFrom:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- if .Values.probes.liveness.enabled }}
      livenessProbe:
        httpGet:
          path: {{ .Values.probes.liveness.path }}
          port: http
        initialDelaySeconds: {{ .Values.probes.liveness.initialDelaySeconds }}
        periodSeconds: {{ .Values.probes.liveness.periodSeconds }}
        timeoutSeconds: {{ .Values.probes.liveness.timeoutSeconds }}
        failureThreshold: {{ .Values.probes.liveness.failureThreshold }}
      {{- end }}
      {{- if .Values.probes.readiness.enabled }}
      readinessProbe:
        httpGet:
          path: {{ .Values.probes.readiness.path }}
          port: http
        initialDelaySeconds: {{ .Values.probes.readiness.initialDelaySeconds }}
        periodSeconds: {{ .Values.probes.readiness.periodSeconds }}
        timeoutSeconds: {{ .Values.probes.readiness.timeoutSeconds }}
        failureThreshold: {{ .Values.probes.readiness.failureThreshold }}
      {{- end }}
      {{- with .Values.resources }}
      resources:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .Values.securityContext }}
      securityContext:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .Values.extraVolumeMounts }}
      volumeMounts:
        {{- toYaml . | nindent 8 }}
      {{- end }}
  {{- with .Values.extraVolumes }}
  volumes:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .Values.nodeSelector }}
  nodeSelector:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .Values.affinity }}
  affinity:
    {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .Values.tolerations }}
  tolerations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end -}}
