output "db_instance_address" {
  description = "The address of the RDS instance"
  value       = aws_db_instance.db_mysql.address
}

output "db_instance_arn" {
  description = "The ARN of the RDS instance"
  value       = aws_db_instance.db_mysql.arn
}

output "db_instance_endpoint" {
  description = "The connection endpoint"
  value       = aws_db_instance.db_mysql.endpoint
}

output "db_instance_engine" {
  description = "The database engine"
  value       = aws_db_instance.db_mysql.engine
}

output "db_instance_engine_version_actual" {
  description = "The running version of the database"
  value       = aws_db_instance.db_mysql.engine_version_actual
}

output "db_instance_name" {
  description = "The database name"
  value       = aws_db_instance.db_mysql.name
}

output "db_instance_username" {
  description = "The master username for the database"
  value       = aws_db_instance.db_mysql.username
  sensitive   = true
}

output "db_instance_password" {
  description = "The database password (this password may be old, because Terraform doesn't track it after initial creation)"
  value       = local.password
  sensitive   = true
}