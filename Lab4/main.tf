terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx"
  keep_locally = false
}

resource "docker_container" "nginx" {
  depends_on = [docker_image.nginx]  # Explicit dependencies

  image = docker_image.nginx.image_id # Implicit dependencies
  name  = "Implicit-Explicit-tutorial"

  ports {
    internal = 81
    external = 8081
  }
}

