# PRIVATE SUBNETS DB
resource "aws_subnet" "private_subnet_db" {
  count                   = length(var.cidr_block_private_sub_db)
  vpc_id                  = aws_vpc.vpc_db.id
  cidr_block              = element(var.cidr_block_private_sub_db, count.index)
  availability_zone       = element(var.availability_zone, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = upper(format("${var.private_subnet_db_name}-%s", element(var.zone, count.index)))
    Tier = "Private"
  }
}

# PRIVATE SUBNETS WORKLOADS
resource "aws_subnet" "private_subnet_workload" {
  count                   = length(var.cidr_block_private_sub_workload)
  vpc_id                  = aws_vpc.vpc_workload.id
  cidr_block              = element(var.cidr_block_private_sub_workload, count.index)
  availability_zone       = element(var.availability_zone, count.index)
  map_public_ip_on_launch = false

  tags = {
    "Name" = upper(format("${var.private_subnet_workload_name}-%s", element(var.zone, count.index)))
    "Tier" = "Private"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

# PUBLIC SUBNETS WORKLOADS
resource "aws_subnet" "public_subnet_workload" {
  count                   = var.create_public_sub == true ? length(var.cidr_block_public_sub_workload) : 0
  vpc_id                  = aws_vpc.vpc_workload.id
  cidr_block              = element(var.cidr_block_public_sub_workload, count.index)
  availability_zone       = element(var.availability_zone, count.index)
  map_public_ip_on_launch = false

  tags = {
    "Name" = upper(format("${var.public_subnet_workload_name}-%s", element(var.zone, count.index)))
    "Tier" = "Public"
    "kubernetes.io/role/elb" = "1"
  }
}