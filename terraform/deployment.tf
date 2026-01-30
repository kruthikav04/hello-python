resource "kubernetes_deployment_v1" "python_app" {
  metadata {
    name      = "python-app"
    namespace = "dev"
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "python"
      }
    }

    template {
      metadata {
        labels = {
          app = "python"
        }
      }

      spec {
        container {
          name  = "python"
          # Use Docker Hub image
          image = "kruthikav04/hello-python:latest"
          image_pull_policy = "Always"

          port {
            container_port = 6001
          }
        }
      }
    }
  }

  # Optional: wait for rollout to complete before Terraform finishes
  wait_for_rollout = true
}

