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
resource "docker_network" "wordpress_net" {
  name = "wordpress_network"
}

# Volumen para MariaDB
resource "docker_volume" "mariadb_data" {
  name = "mariadb_data"
}

# Contenedor MariaDB
resource "docker_image" "mariadb" {
  name         = "mariadb:latest"
  keep_locally = false
}

resource "docker_container" "mariadb" {
  name  = "mariadb_container"
  image = docker_image.mariadb.image_id

  env = [
    "MYSQL_ROOT_PASSWORD=${var.mysql_root_password}",
    "MYSQL_DATABASE=${var.mysql_database}",
    "MYSQL_USER=${var.mysql_user}",
    "MYSQL_PASSWORD=${var.mysql_password}"
  ]

  volumes {
    volume_name    = docker_volume.mariadb_data.name
    container_path = "/var/lib/mysql"
  }

  networks_advanced {
    name = docker_network.wordpress_net.name
  }
}

# Contenedor WordPress
resource "docker_image" "wordpress" {
  name         = "wordpress:latest"
  keep_locally = false
}

resource "docker_container" "wordpress" {
  name  = "wordpress_container"
  image = docker_image.wordpress.image_id

  ports {
    internal = 80
    external = 8080
  }

  env = [
    "WORDPRESS_DB_HOST=${var.wordpress_db_host}",
    "WORDPRESS_DB_NAME=${var.mysql_database}",
    "WORDPRESS_DB_USER=${var.mysql_user}",
    "WORDPRESS_DB_PASSWORD=${var.mysql_password}"
  ]

  networks_advanced {
    name = docker_network.wordpress_net.name
  }

  depends_on = [docker_container.mariadb]
}
