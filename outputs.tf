output "image_id" {
  description = "ID da imagem"
  value       = docker_image.nginx.id
}

output "container_id" {
  description = "ID do container"
  value       = docker_container.nginx.id
}