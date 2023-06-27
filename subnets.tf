# PRIVATE SUBNETS DB
resource "aws_subnet" "private_subnet_db" {
  count                   = var.create_vpc_db == true ? length(var.cidr_block_private_sub_db) : 0
  vpc_id                  = aws_vpc.vpc_db[0].id
  cidr_block              = element(var.cidr_block_private_sub_db, count.index)
  availability_zone       = element(var.availability_zone, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = lower(format("${var.private_subnet_db_name}-%s", element(var.zone, count.index)))
    Tier = "Private"
  }
}

# PRIVATE SUBNETS appS
resource "aws_subnet" "private_subnet_app" {
  count                   = length(var.cidr_block_private_sub_app)
  vpc_id                  = aws_vpc.vpc_app.id
  cidr_block              = element(var.cidr_block_private_sub_app, count.index)
  availability_zone       = element(var.availability_zone, count.index)
  map_public_ip_on_launch = false

  tags = {
    "Name" = lower(format("${var.private_subnet_app_name}-%s", element(var.zone, count.index)))
    "Tier" = "Private"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

# PUBLIC SUBNETS appS
resource "aws_subnet" "public_subnet_app" {
  count                   = var.create_public_sub == true ? length(var.cidr_block_public_sub_app) : 0
  vpc_id                  = aws_vpc.vpc_app.id
  cidr_block              = element(var.cidr_block_public_sub_app, count.index)
  availability_zone       = element(var.availability_zone, count.index)
  map_public_ip_on_launch = false

  tags = {
    "Name" = lower(format("${var.public_subnet_app_name}-%s", element(var.zone, count.index)))
    "Tier" = "Public"
    "kubernetes.io/role/elb" = "1"
  }
}