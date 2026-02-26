terraform {
  required_version = ">= 1.5.0"
}

module "aegis" {
  source = "../.."

  release_name = "aegis-prod"
  namespace    = "aegis-prod"

  chart_version = "0.1.0"

  control_plane = {
    enabled  = true
    replicas = 2
    resources = {
      requests = {
        cpu    = "250m"
        memory = "256Mi"
      }
      limits = {
        cpu    = "1"
        memory = "1Gi"
      }
    }
    service = {
      type = "ClusterIP"
      port = 8443
    }
  }

  agent = {
    enabled           = true
    control_plane_url = "https://axis.velikey.com"
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
  }

  tls = {
    enabled = false
    cert_manager = {
      enabled     = false
      issuer_name = ""
    }
  }

  environment_variables = {
    AEGIS_ACCEPT_INVALID_CERTS     = "false"
    AEGIS_ACCEPT_INVALID_HOSTNAMES = "false"
  }
}
