terraform {
  required_version = ">= 1.5.0"
}

module "aegis" {
  source = "../.."

  namespace = "aegis-basic"
}
