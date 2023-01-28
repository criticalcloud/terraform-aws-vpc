# VPC DB
resource "aws_vpc" "vpc_db" {
  cidr_block         = var.cidr_vpc_db
  enable_dns_support = true

  tags = {
    Name = lower(var.vpc_name_db)
  }
}

# VPC app
resource "aws_vpc" "vpc_app" {
  cidr_block         = var.cidr_vpc_app
  enable_dns_support = true

  tags = {
    Name = lower(var.vpc_name_app)
  }
}

# VPC PEERING
resource "aws_vpc_peering_connection" "px_app_db" {
  peer_owner_id = data.aws_caller_identity.current.account_id
  peer_vpc_id   = aws_vpc.vpc_db.id
  vpc_id        = aws_vpc.vpc_app.id
  auto_accept   = true

  tags = {
    Name = "px-app-db"
  }
}

# GET ACCOUNT ID
data "aws_caller_identity" "current" {}