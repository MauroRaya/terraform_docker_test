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
  for_each = tomap(var.container_ports)

  image = docker_image.nginx.image_id
  name  = "container-${each.key}"

  ports {
    internal = 80
    external = each.value
  }

  depends_on = [docker_image.nginx]
}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}
