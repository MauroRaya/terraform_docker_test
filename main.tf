terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "null_resource" "build_docker_image" {
  provisioner "local-exec" {
    command = "docker build -t ubuntu-ssh ${path.module}"
  }
}

resource "docker_image" "ubuntu" {
  name       = var.ubuntu_ssh_image
  depends_on = [null_resource.build_docker_image]
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