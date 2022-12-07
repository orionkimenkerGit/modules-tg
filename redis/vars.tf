variable "name" {
  type    = string
}
variable "engine" {
  type    = string
}
variable "node_type" {
  type    = string
}
variable "num_cache_nodes" {
  type    = number
}
variable "parameter_group_name" {
  type    = string
}
variable "engine_version" {
  type    = string
}
variable "port" {
  type    = number
}
variable "subnet_ids" {
  type = string
}
variable "security_group_ids" {
  type = string
}