terraform {
  required_version = ">= 1.1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.4"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }
  }
}

locals {
  create_random_password = var.create_random_password
  password               = local.create_random_password ? random_password.master_password[0].result : var.master_password
}

data "aws_availability_zones" "available" {}

data "aws_vpc" "this" {
  id = var.vpc_specific_id == "" ? var.vpc_id : var.vpc_specific_id
}


### Username and password section

resource "random_password" "master_password" {
  count = var.create_random_password ? 1 : 0

  length = 24
  # Some special characters are not supported
  special          = true
  override_special = "!$%^&*-=<>"
  min_lower        = 2
  min_numeric      = 2
  min_special      = 2
  min_upper        = 2
}

### Network section

data "aws_subnets" "this" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

resource "aws_db_subnet_group" "this" {
  count      = var.aws_db_subnet_group != "" ? 0 : 1
  subnet_ids = var.private_subnet_ids
  tags = {
    Name = "MySQL subnet group"
  }
}

# Section of creating DB
######################################

resource "aws_db_instance" "db_mysql" {
  identifier             = var.identifier
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  storage_encrypted      = var.storage_encrypted
  engine                 = var.engine
  engine_version         = var.engine_version
  db_name                = var.db_name
  username               = var.username
  password               = local.password
  db_subnet_group_name   = var.aws_db_subnet_group == "" ? aws_db_subnet_group.this[0].id : var.aws_db_subnet_group
  vpc_security_group_ids = var.vpc_security_group_ids
  publicly_accessible    = var.publicly_accessible
  skip_final_snapshot    = var.skip_final_snapshot
  # parameter_group_name   = aws_db_parameter_group.this.name.  ### this variable will used in future
}