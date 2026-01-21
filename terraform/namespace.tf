resource "kubernetes_namespace_v1" "dev" {
  metadata {
    name = "dev"
  }
}

