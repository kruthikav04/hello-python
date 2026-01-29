resource "kubernetes_service_v1" "python_service" {
  metadata {
    name      = "python-service"
    namespace = "dev"
  }
  spec {
    selector = {
      app = "python"
    }
    port {
      port        = 80
      target_port = 6001
      node_port   = 30007
    }
    type = "NodePort"   # <- change this from LoadBalancer
  }
}

