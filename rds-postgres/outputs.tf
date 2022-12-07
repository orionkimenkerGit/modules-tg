output "pg_instance_endpoint" {
  description = "The connection endpoint"
  value       = aws_db_instance.db_postgresql.endpoint
}

output "pg_instance_name" {
  description = "The database name"
  value       = aws_db_instance.db_postgresql.db_name
}

output "pg_instance_username" {
  description = "The master username for the database"
  value       = var.username #aws_db_instance.db_postgresql.master_username
  sensitive   = true
}

output "pg_instance_password" {
  description = "The database password (this password may be old, because Terraform doesn't track it after initial creation)"
  value       = local.master_password
  sensitive   = true
}