# Tell Terraform which provider to use
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# Configure the Docker provider
provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Pull the image we built
resource "docker_image" "devsecops_app" {
  name         = "devsecops-app:latest"
  keep_locally = true
}

# Create and run the container
resource "docker_container" "devsecops_app" {
  name  = "devsecops-terraform"
  image = docker_image.devsecops_app.image_id

  ports {
    internal = 5000
    external = 5001
  }

  env = [
    "FLASK_DEBUG=false",
    "FLASK_HOST=0.0.0.0",
    "FLASK_PORT=5000"
  ]

  restart = "unless-stopped"
}
