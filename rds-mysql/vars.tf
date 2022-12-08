variable "name" {
  description = "Environment Name"
  type        = string
}
variable "storage_encrypted" {
  description = "Enable storage encryption"
  type        = bool
}
variable "create_random_password" {
  description = "Whether to create random password for RDS DB"
  type        = bool
}
variable "master_password" {
  description = "RDS database password. Note - when specifying a value here, 'create_random_password' should be set to `false`"
  type        = string
  sensitive   = true
}
variable "skip_final_snapshot" {
  description = "Skip final snapshot"
  type        = bool
}
variable "identifier" {
  description = "RDS identifier of DB"
  type        = string
}
variable "vpc_id" {
  description = "VPC ID for RDS cluster"
  type        = string
}
variable "deletion_protection" {
  description = "The database can't be deleted when this value is set to true (useful for prod)"
  type        = bool
}
# Parameter group
variable "private_subnet_ids" {
  type = list(string)
  description = "List of VPC Private Subnets"
}
variable "instance_class" {
  description = "DB instance class"
  type        = string
}
variable "allocated_storage" {
  description = "Storage size for DB"
  type        = number
}
variable "engine_version" {
  description = "DB engine version"
  type        = string
}
variable "engine" {
  description = "RDS engine type"
  type        = string
}
variable "db_name" {
  description = "MySQL DB name"
  type        = string
  default = "default_name"
}
variable "username" {
  description = "RDS database admin username"
  type        = string
  sensitive   = true
}
variable "publicly_accessible" {
  description = "control if instance is publicly accessible"
  type        = bool
}
variable "vpc_security_group_ids" {
  description = "Attach VPC security groups to DB instance"
  type        = list(any)
}