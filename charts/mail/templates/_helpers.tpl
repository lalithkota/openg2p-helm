{{/*
Render Env values section
*/}}
{{- define "mail.envVars" -}}
{{- range $k, $v := .Values.envVars }}
- name: {{ $k }}
  value: {{ tpl $v $ | quote }}
{{- end }}
{{- range $k, $v := .Values.envVarsFrom }}
- name: {{ $k }}
  valueFrom:
    {{- if $v.configMapKeyRef }}
    configMapKeyRef:
      name: {{ tpl $v.configMapKeyRef.name $ | quote }}
      key: {{ tpl $v.configMapKeyRef.key $ | quote }}
    {{- else if $v.secretKeyRef }}
    secretKeyRef:
      name: {{ tpl $v.secretKeyRef.name $ | quote }}
      key: {{ tpl $v.secretKeyRef.key $ | quote }}
    {{- end }}
{{- end }}
{{- end }}
