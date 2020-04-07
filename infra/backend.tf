terraform {
  required_version = "~> 0.12.0"
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "devoteam-k8s"
    workspaces {
      name = "kubernetes-on-azure-dev"
    }
    token = "Uzk2KZnJ2kb5mQ.atlasv1.Qupvx1DPtJppcFF4iz2c1Yt79smU3z3yKjL6SxBYgJszjmZbzvghy7ZbQz59QmHsSDA"
  }
}