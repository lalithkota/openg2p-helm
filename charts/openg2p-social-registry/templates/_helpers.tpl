{{/*
Expand the name of the chart.
*/}}
{{- define "socialRegistry.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "socialRegistry.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "socialRegistry.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "socialRegistry.labels" -}}
helm.sh/chart: {{ include "socialRegistry.chart" . }}
{{ include "socialRegistry.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "socialRegistry.selectorLabels" -}}
app.kubernetes.io/name: {{ include "socialRegistry.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/* All hostnames */}}

{{/* TODO: perform check here if ingress/istio */}}
{{- define "socialRegistry.hostname" -}}
{{- if .Values.istio.virtualservice.host -}}
{{ .Values.istio.virtualservice.host }}
{{- else -}}
{{ .Values.global.hostname }}
{{- end -}}
{{- end -}}

{{/* End - All hostnames */}}
