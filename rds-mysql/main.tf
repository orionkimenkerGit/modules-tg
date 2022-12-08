# ---------------------------------------------------------------------------------------------------------------------
# A SIMPLE EXAMPLE OF HOW TO DEPLOY MYSQL ON RDS
# This is an example of how to use Terraform to deploy a MySQL database on Amazon RDS.
#
# Note: This code is meant solely as a simple demonstration of how to lay out your files and folders with Terragrunt
# in a way that keeps your Terraform code DRY. This is not production-ready code, so use at your own risk.
# ---------------------------------------------------------------------------------------------------------------------

terraform {
  # Live modules pin exact Terraform version; generic modules let consumers pin the version.
  # The latest version of Terragrunt (v0.36.0 and above) recommends Terraform 1.1.4 or above.
  required_version = ">= 1.1.6"

  # Live modules pin exact provider version; generic modules let consumers pin the version.
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.4"
    }
  }
}
locals {
  create_random_password=var.create_random_password
  password = local.create_random_password ? create_random_password.master_password[0].result : var.master_password
}
data "aws_availability_zones" "available" {}
data "aws_vpc" "this" {
  id = var.vpc_specific_id == "" ? var.vpc_id : var.vpc_specific_id
}

resource "random_password" "master_password" {
  count = var.create_random_password ? 1 : 0
  length = 24
  special = true
  override_special = "!$%^&*-=<>"
  min_lower = 2 
  min_numeric = 2
  min_special = 2
  min_upper = 2
}

data "aws_subnets" "this" {
  filter {
    name = "vpc-id"
    values = [var.vpc_id]
  }
}

resource "aws_db_subnet_group" "this" {
  count = var.aws_db_subnet_group != "" ? 0 : 1
  subnet_ids = flatten([var.private_subnet_ids])
  tags = {
    Name = "MySQL subnet group"
  }
}
# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE MYSQL DB
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_db_instance" "db_mysql" {
  identifier = var.identifier
  instance_class = var.instance_class
  allocated_storage = var.allocated_storage
  storage_encrypted = var.storage_encrypted
  engine = var.engine
  engine_version = var.engine_version
  db_name = var.db_name
  username = var.username
  password = local.password 
  db_subnet_group_name = var.aws_db_subnet_group == "" ? aws_db_subnet_group.this[0].id : var.aws_db_subnet_group
  vpc_security_group_ids = var.vpc_security_group_ids
  publicly_accessible = var.publicly_accessible
  skip_final_snapshot = var.skip_final_snapshot
}