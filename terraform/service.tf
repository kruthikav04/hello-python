resource "kubernetes_service_v1" "python_service" {
  metadata {
    name      = "python-service"
    namespace = kubernetes_namespace_v1.dev.metadata[0].name
  }

  spec {
    selector = {
      app = "python"
    }

    port {
      port        = 6001
      target_port = 6001
    }

    type = "NodePort"
  }
}

