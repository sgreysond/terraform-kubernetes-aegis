variable "release_name" {
  description = "Name of the Helm release"
  type        = string
  default     = "aegis"
}

variable "chart_repository" {
  description = "OCI chart repository URL"
  type        = string
  default     = "oci://ghcr.io/sgreysond/charts"
}

variable "chart_name" {
  description = "Name of the Helm chart"
  type        = string
  default     = "aegis"
}

variable "chart_version" {
  description = "Version of the Helm chart"
  type        = string
  default     = "0.1.0"
}

variable "namespace" {
  description = "Kubernetes namespace"
  type        = string
  default     = "aegis-system"
}

variable "create_namespace" {
  description = "Create namespace if it does not exist"
  type        = bool
  default     = true
}

variable "name_prefix" {
  description = "Prefix used in module outputs"
  type        = string
  default     = "aegis"
}

variable "image_pull_policy" {
  description = "Kubernetes image pull policy"
  type        = string
  default     = "IfNotPresent"
}

variable "control_plane_image" {
  description = "Control-plane image configuration"
  type = object({
    repository = string
    tag        = string
  })
  default = {
    repository = "ghcr.io/velikey/aegis-control-plane"
    tag        = "0.1.0"
  }
}

variable "agent_image" {
  description = "Agent image configuration"
  type = object({
    repository = string
    tag        = string
  })
  default = {
    repository = "ghcr.io/velikey/aegis-agent"
    tag        = "0.1.0"
  }
}

variable "control_plane" {
  description = "Control-plane deployment settings"
  type = object({
    enabled  = bool
    replicas = number
    resources = object({
      requests = map(string)
      limits   = map(string)
    })
    service = object({
      type = string
      port = number
    })
  })
  default = {
    enabled  = true
    replicas = 1
    resources = {
      requests = {
        cpu    = "100m"
        memory = "128Mi"
      }
      limits = {
        cpu    = "500m"
        memory = "512Mi"
      }
    }
    service = {
      type = "ClusterIP"
      port = 8443
    }
  }
}

variable "agent" {
  description = "Agent deployment settings"
  type = object({
    enabled           = bool
    control_plane_url = string
    resources = object({
      requests = map(string)
      limits   = map(string)
    })
  })
  default = {
    enabled           = true
    control_plane_url = ""
    resources = {
      requests = {
        cpu    = "50m"
        memory = "64Mi"
      }
      limits = {
        cpu    = "200m"
        memory = "256Mi"
      }
    }
  }
}

variable "tls" {
  description = "TLS settings for control-plane ingress to chart"
  type = object({
    enabled = bool
    cert_manager = object({
      enabled     = bool
      issuer_name = string
    })
  })
  default = {
    enabled = false
    cert_manager = {
      enabled     = false
      issuer_name = ""
    }
  }
}

variable "bearer_token" {
  description = "Bootstrap token injected into agent secret (optional)"
  type        = string
  default     = ""
  sensitive   = true
}

variable "environment_variables" {
  description = "Additional agent env vars injected through ConfigMap"
  type        = map(string)
  default     = {}
}

variable "helm_values" {
  description = "Additional Helm --set values"
  type        = map(string)
  default     = {}
}
