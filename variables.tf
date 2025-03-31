variable "network_name" {
  description = "Nombre de la red Docker"
  type        = string
  default     = "wordpress_network"
}

variable "db_container_name" {
  description = "Nombre del contenedor de la base de datos"
  type        = string
  default     = "mariadb_container"
}

variable "db_root_password" {
  description = "Contraseña de root de la base de datos"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Nombre de la base de datos"
  type        = string
  default     = "wordpress_db"
}

variable "db_user" {
  description = "Usuario de la base de datos"
  type        = string
  default     = "wordpress_user"
}

variable "db_password" {
  description = "Contraseña del usuario de la base de datos"
  type        = string
  sensitive   = true
}

variable "wordpress_container_name" {
  description = "Nombre del contenedor de WordPress"
  type        = string
  default     = "wordpress_container"
}

variable "wordpress_port" {
  description = "Puerto en el que se ejecutará WordPress"
  type        = number
  default     = 8080
}