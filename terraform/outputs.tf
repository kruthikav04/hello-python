output "service_port" {
  value = kubernetes_service_v1.python_service.spec[0].port[0].node_port
}

output "namespace_name" {
  value = kubernetes_namespace_v1.dev.metadata[0].name
}
