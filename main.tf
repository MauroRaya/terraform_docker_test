terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "container-${count.index + 1}"

  ports {
    internal = 80
    external = 8080 + count.index
  }

  depends_on = [docker_image.nginx]
  count      = var.container_count
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}
