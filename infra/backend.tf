terraform {
  required_version = "~> 0.12.0"
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "devoteam-k8s"
    workspaces {
      name = "kubernetes-on-azure-dev"
    }
    token = var.terraform_token
  }
}
