# VPC DB
resource "aws_vpc" "vpc_db" {
  count = var.create_vpc_db == true ? 1 : 0
  cidr_block         = var.cidr_vpc_db
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = lower(var.vpc_name_db)
  }
}

# VPC app
resource "aws_vpc" "vpc_app" {
  cidr_block         = var.cidr_vpc_app
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = lower(var.vpc_name_app)
  }
}

# VPC PEERING
resource "aws_vpc_peering_connection" "px_app_db" {
  count = var.create_vpc_db == true ? 1 : 0
  peer_owner_id = data.aws_caller_identity.current.account_id
  peer_vpc_id   = aws_vpc.vpc_db[count.index].id
  vpc_id        = aws_vpc.vpc_app.id
  auto_accept   = true

  tags = {
    Name = "px-app-db"
  }
}

# GET ACCOUNT ID
data "aws_caller_identity" "current" {}