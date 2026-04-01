output "ecr_repository_url" {
  description = "ECR repository URL"
  value       = aws_ecr_repository.app.repository_url
}

output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = aws_ecs_cluster.this.name
}

output "ecs_service_name" {
  description = "ECS service name"
  value       = aws_ecs_service.app.name
}

output "task_definition_family" {
  description = "Task definition family"
  value       = aws_ecs_task_definition.app.family
}

output "load_balancer_dns_name" {
  description = "Application URL"
  value       = aws_lb.app.dns_name
}