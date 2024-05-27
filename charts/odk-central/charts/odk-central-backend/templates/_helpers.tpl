{{/*
Render Env values section
*/}}
{{- define "odkBackend.envVars" -}}
{{- range $k, $v := .Values.envVars }}
- name: {{ $k }}
  value: {{- include "common.tplvalues.render" ( dict "value" $v "context" $ ) | quote }}
{{- end }}
{{- range $k, $v := .Values.envVarsFrom }}
- name: {{ $k }}
  valueFrom:
    {{- if $v.configMapKeyRef }}
    configMapKeyRef:
      name: {{- include "common.tplvalues.render" ( dict "value" $v.configMapKeyRef.name "context" $ ) | quote }}
      key: {{- include "common.tplvalues.render" ( dict "value" $v.configMapKeyRef.key "context" $ ) | quote }}
    {{- else if $v.secretKeyRef }}
    secretKeyRef:
      name: {{- include "common.tplvalues.render" ( dict "value" $v.secretKeyRef.name "context" $ ) | quote }}
      key: {{- include "common.tplvalues.render" ( dict "value" $v.secretKeyRef.key "context" $ ) | quote }}
    {{- end }}
{{- end }}
{{- end }}
