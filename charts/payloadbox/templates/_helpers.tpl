{{/*
Build the merged envMap for the PayloadBox container.

Returns a YAML object that combines the typed payloadbox.* keys with any
user-supplied extraEnvMap entries (extraEnvMap wins on conflict).
*/}}
{{- define "payloadbox.envMap" -}}
{{- $port := int (default 8080 .Values.containerPort) -}}
{{- $base := dict
  "LISTEN_ADDRESS" (printf ":%d" $port)
  "MAX_BODY_SIZE_BYTES" (printf "%d" (int .Values.payloadbox.maxBodySizeBytes))
  "MAX_RECORDS_TO_STORE" (printf "%d" (int .Values.payloadbox.maxRecordsToStore))
  "LOG_HTTP_REQUESTS" (toString .Values.payloadbox.logHttpRequests)
  "LOG_LEVEL" .Values.payloadbox.logLevel
-}}
{{- mergeOverwrite $base (default (dict) .Values.extraEnvMap) | toYaml -}}
{{- end -}}
