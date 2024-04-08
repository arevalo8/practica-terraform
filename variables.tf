variable "wordpress_db_name" {
  description = "Nombre de la base de datos de WordPress"
  type        = string
  default     = "wordpressdb"
}

variable "wordpress_db_user" {
  description = "Usuario de la base de datos de WordPress"
  type        = string
  default     = "wordpressuser"
}

variable "wordpress_db_password" {
  description = "Contraseña de la base de datos de WordPress"
  type        = string
  default     = "password123"
}

variable "db_root_password" {
  description = "Contraseña root de la base de datos"
  type        = string
  default     = "password1234"
}
