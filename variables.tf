variable "mysql_root_password" {
  description = "Root password for MariaDB"
  type        = string
  default     = "rootpass"
}

variable "mysql_database" {
  description = "Database name for WordPress"
  type        = string
  default     = "wordpress_db"
}

variable "mysql_user" {
  description = "Database user for WordPress"
  type        = string
  default     = "wp_user"
}

variable "mysql_password" {
  description = "Database user password"
  type        = string
  default     = "wp_pass"
}

variable "wordpress_db_host" {
  description = "Hostname of the database for WordPress"
  type        = string
  default     = "mariadb_container:3306"
}
