variable "environment" {
  description = "Environment Name"
  type        = string
}

variable "storage_encrypted" {
  description = "Enable storage encryption"
  type        = bool
}

variable "master_username" {
  description = "RDS database master username"
  type        = string
  sensitive   = true
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

variable "vpc_specific_id" {
  description = "ID if pre-installed vpc"
  type        = string
}

variable "deletion_protection" {
  description = "The database can't be deleted when this value is set to true (useful for prod)"
  type        = bool
}

# Parameter group
variable "parameter_group_family" {
  description = "The family of the DB cluster parameter group"
  type        = string
}

variable "private_subnet_ids" {
  type = string
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
  description = "Postgres DB name"
  type        = string

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
  description = "vpc_security_group_ids"
  type        = list(any)
}
variable "aws_db_subnet_group" {
  type = string
}