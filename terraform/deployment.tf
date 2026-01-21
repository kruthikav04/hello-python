resource "kubernetes_deployment_v1" "python_app" {
  metadata {
    name      = "python-app"
    namespace = "dev"
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

