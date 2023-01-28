# RANGE IP VPC DB
variable "cidr_vpc_db" {}

# RANGE IP VPC WORKLOAD
variable "cidr_vpc_workload" {}

# NAME VPC DB
variable "vpc_name_db" {}

# NAME VPC WORKLOAD
variable "vpc_name_workload" {}

# RANGE IPS PRIVATE SUBNETES DB
variable "cidr_block_private_sub_db" {
  type = list(any)
}

# RANGE IPS PRIVATE SUBNETES WORKLOAD
variable "cidr_block_private_sub_workload" {
  type = list(any)
}

# RANGE IPS PUBLIC SUBNETES WORKLOAD
variable "cidr_block_public_sub_workload" {
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
  default = ["A", "B", "C"]
}

# PRIVATE SUBNET DB NAME
variable "private_subnet_db_name" {}

# PRIVATE SUBNET WORKLOAD NAME
variable "private_subnet_workload_name" {}

# PUBLIC SUBNET WORKLOAD NAME
variable "public_subnet_workload_name" {}

# PUBLIC SUBNET WORKLOAD NAME
variable "create_public_sub" {
  default = true
}

# REGIAO AWS
variable "region" {
  default = "sa-east-1"
}