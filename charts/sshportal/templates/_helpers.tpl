{{/*
Expand the name of the chart.
*/}}
{{- define "sshportal.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "sshportal.fullname" -}}
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
{{- define "sshportal.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Midokura labels
*/}}
{{- define "charts.midokura.labels" -}}
{{- if .Values.global }}

{{- if .Values.global.team }}
team: {{ .Values.global.team }}
{{- end }}

{{- if .Values.global.service }}
service: {{ .Values.global.service }}
{{- end }}

{{- end }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "sshportal.labels" -}}
helm.sh/chart: {{ include "sshportal.chart" . }}
{{ include "sshportal.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{ include "charts.midokura.labels" . }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "sshportal.selectorLabels" -}}
app.kubernetes.io/name: {{ include "sshportal.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "sshportal.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "sshportal.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
