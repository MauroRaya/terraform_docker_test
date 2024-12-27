variable "container_ports" {
  default = {
    1 : 8080,
    2 : 8081,
    3 : 8082
  }
}

variable "docker_image_name" {
  default = "nginx:latest"

  validation {
    condition     = can(regex("^nginx:.+", var.docker_image_name))
    error_message = "The Docker image name must start with 'nginx:'"
  }
}