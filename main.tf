terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

# Red Docker
resource "docker_network" "wp_network" {
  name = "wp_network"
}

# Volumen para la base de datos
resource "docker_volume" "db_volume" {
  name = "db_volume"
}

# Contenedor MariaDB
resource "docker_container" "mariadb" {
  image = "mariadb:latest"
  name  = "mariadb_container"
  restart = "always"

  env = [
    "MYSQL_ROOT_PASSWORD=${var.db_root_password}",
    "MYSQL_DATABASE=${var.db_name}",
    "MYSQL_USER=${var.db_user}",
    "MYSQL_PASSWORD=${var.db_password}"
  ]

  volumes {
    volume_name    = docker_volume.db_volume.name
    container_path = "/var/lib/mysql"
  }

  networks_advanced {
    name = docker_network.wp_network.name
  }
}

# Contenedor WordPress
resource "docker_container" "wordpress" {
  image = "wordpress:latest"
  name  = "wordpress_container"
  restart = "always"

  env = [
    "WORDPRESS_DB_HOST=mariadb_container",
    "WORDPRESS_DB_NAME=${var.db_name}",
    "WORDPRESS_DB_USER=${var.db_user}",
    "WORDPRESS_DB_PASSWORD=${var.db_password}"
  ]

  ports {
    internal = 80
    external = 8080
  }

  networks_advanced {
    name = docker_network.wp_network.name
  }
}
