terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "docker_image" "ubuntu" {
  name = var.ubuntu_ssh_image
}

resource "docker_container" "ubuntu" {
  image = docker_image.ubuntu.image_id
  name  = "container-ubuntu"

  ports {
    internal = 22
    external = 2222
  }

  connection {
    type = "ssh"
    user = "root"
    host = self.network_data[0].gateway
  }
}