# terraform-kubernetes-aegis

Public Terraform module to deploy the VeliKey Aegis Helm chart on Kubernetes.

## What this module does

- Installs the `aegis` Helm chart via `helm_release`.
- Exposes core inputs for namespace, chart version, images, and agent bootstrap token.
- Supports additional chart overrides via `helm_values`.

## Usage

```hcl
module "aegis" {
  source  = "sgreysond/aegis/kubernetes"
  version = "0.1.0"

  namespace = "aegis-system"

  agent = {
    enabled           = true
    control_plane_url = "https://axis.velikey.com"
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

  bearer_token = var.aegis_bootstrap_token
}
```

## Requirements

- Terraform `>= 1.5.0`
- Helm provider `~> 2.0`
- Kubernetes provider `~> 2.0`

## Examples

- `examples/basic`
- `examples/complete`

## Release process

1. Open PR to `main` and pass CI.
2. Tag with `vX.Y.Z`.
3. Push tag.
4. Terraform Registry ingests from the public repository.

## License

Apache-2.0
