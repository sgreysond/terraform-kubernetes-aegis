output "helm_release_name" {
  description = "Name of the deployed Helm release"
  value       = helm_release.aegis.name
}

output "namespace" {
  description = "Namespace where Aegis is deployed"
  value       = helm_release.aegis.namespace
}

output "control_plane_service" {
  description = "Control-plane service name"
  value       = "${var.name_prefix}-control-plane"
}

output "control_plane_url" {
  description = "Internal control-plane service URL"
  value       = "https://${var.name_prefix}-control-plane.${var.namespace}.svc.cluster.local:${var.control_plane.service.port}"
}

output "chart_version" {
  description = "Resolved deployed chart version"
  value       = helm_release.aegis.version
}

output "status" {
  description = "Helm release status"
  value       = helm_release.aegis.status
}
