resource "helm_release" "aegis" {
  name       = var.release_name
  repository = var.chart_repository
  chart      = var.chart_name
  version    = var.chart_version
  namespace  = var.namespace

  create_namespace = var.create_namespace

  values = [
    yamlencode({
      global = {
        imagePullPolicy = var.image_pull_policy
      }

      controlPlane = {
        enabled   = var.control_plane.enabled
        image     = "${var.control_plane_image.repository}:${var.control_plane_image.tag}"
        replicas  = var.control_plane.replicas
        service   = var.control_plane.service
        resources = var.control_plane.resources
        tls = {
          enabled = var.tls.enabled
          certManager = {
            enabled = var.tls.cert_manager.enabled
            issuerRef = {
              name = var.tls.cert_manager.issuer_name
            }
          }
        }
      }

      agent = {
        enabled         = var.agent.enabled
        image           = "${var.agent_image.repository}:${var.agent_image.tag}"
        controlPlaneUrl = var.agent.control_plane_url
        resources       = var.agent.resources
        config = {
          create = true
          data   = var.environment_variables
        }
        secret = {
          create         = var.bearer_token != ""
          bootstrapToken = var.bearer_token
        }
      }
    })
  ]

  dynamic "set" {
    for_each = var.helm_values
    content {
      name  = set.key
      value = set.value
    }
  }
}
