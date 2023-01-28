# RANGE IP VPC DB
variable "cidr_vpc_db" {}

# RANGE IP VPC app
variable "cidr_vpc_app" {}

# NAME VPC DB
variable "vpc_name_db" {}

# NAME VPC app
variable "vpc_name_app" {}

# RANGE IPS PRIVATE SUBNETES DB
variable "cidr_block_private_sub_db" {
  type = list(any)
}

# RANGE IPS PRIVATE SUBNETES app
variable "cidr_block_private_sub_app" {
  type = list(any)
}

# RANGE IPS PUBLIC SUBNETES app
variable "cidr_block_public_sub_app" {
  type = list(any)
}

# AVAILABILITY ZONES
variable "availability_zone" {
  type    = list(any)
  default = ["sa-east-1a", "sa-east-1b", "sa-east-1c"]
}

# ZONAS
variable "zone" {
  type    = list(any)
  default = ["a", "b", "c"]
}

# PRIVATE SUBNET DB NAME
variable "private_subnet_db_name" {}

# PRIVATE SUBNET app NAME
variable "private_subnet_app_name" {}

# PUBLIC SUBNET app NAME
variable "public_subnet_app_name" {}

# PUBLIC SUBNET app NAME
variable "create_public_sub" {
  default = true
}

# REGIAO AWS
variable "region" {
  default = "sa-east-1"
}