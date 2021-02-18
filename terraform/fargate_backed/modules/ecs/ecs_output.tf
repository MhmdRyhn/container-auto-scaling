output "ecs_cluster" {
  value = aws_ecs_cluster.container_cluster
}

output "ecs_service" {
  value = aws_ecs_service.container_service
}
