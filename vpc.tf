# VPC DB
resource "aws_vpc" "vpc_db" {
  cidr_block         = var.cidr_vpc_db
  enable_dns_support = true

  tags = {
    Name = lower(var.vpc_name_db)
  }
}

# VPC WORKLOAD
resource "aws_vpc" "vpc_workload" {
  cidr_block         = var.cidr_vpc_workload
  enable_dns_support = true

  tags = {
    Name = lower(var.vpc_name_workload)
  }
}

# VPC PEERING
resource "aws_vpc_peering_connection" "px_workload_db" {
  peer_owner_id = data.aws_caller_identity.current.account_id
  peer_vpc_id   = aws_vpc.vpc_db.id
  vpc_id        = aws_vpc.vpc_workload.id
  auto_accept   = true

  tags = {
    Name = "PX-WORKLOAD-DB"
  }
}

# GET ACCOUNT ID
data "aws_caller_identity" "current" {}