resource "kubernetes_namespace_v1" "dev" {
  metadata {
    name = "dev"
  }
}

resource "kubernetes_deployment_v1" "python_app" {
  metadata {
    name      = "python-app"
    namespace = kubernetes_namespace_v1.dev.metadata[0].name
    labels    = { app = "python" }
  }

  spec {
    replicas = 2

    selector {
      match_labels = { app = "python" }
    }

    template {
      metadata {
        labels = { app = "python" }
      }

      spec {
        container {
          name  = "python"
          image = "hello-python:latest"
          port {
            container_port = 6001
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "python_service" {
  metadata {
    name      = "python-service"
    namespace = kubernetes_namespace_v1.dev.metadata[0].name
  }

  spec {
    type     = "NodePort"
    selector = { app = "python" }

    port {
      port        = 6001
      target_port = 6001
      node_port   = 31708
    }
  }
}
