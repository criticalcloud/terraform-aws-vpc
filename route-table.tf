# ROUTE TABLE VPC DB SUBNETES PRIVADAS
resource "aws_route_table" "route_private_db" {
  vpc_id = aws_vpc.vpc_db.id

  route {
    cidr_block                = var.cidr_vpc_workload
    vpc_peering_connection_id = aws_vpc_peering_connection.px_workload_db.id
  }

  tags = {
    Name = "${var.private_subnet_db_name}"
  }
}

# ROUTE TABLE VPC WORKLOAD SUBNETES PRIVADAS
resource "aws_route_table" "route_private_workload" {
  vpc_id = aws_vpc.vpc_workload.id

  route {
    cidr_block                = var.cidr_vpc_db
    vpc_peering_connection_id = aws_vpc_peering_connection.px_workload_db.id
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ng_workload[0].id
  }

  tags = {
    Name = "${var.private_subnet_workload_name}"
  }
}

# ROUTE TABLE VPC WORKLOAD SUBNETES PUBLICAS
resource "aws_route_table" "route_public_workload" {
  count  = var.create_public_sub == true ? 1 : 0
  vpc_id = aws_vpc.vpc_workload.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig_workload.id
  }

  tags = {
    Name = "${var.public_subnet_workload_name}"
  }
}

# ADD ROUTE TABLE SUBNETS PRIVADAS DB
resource "aws_route_table_association" "rta_private_db" {
  count          = length(var.cidr_block_private_sub_db)
  subnet_id      = aws_subnet.private_subnet_db[count.index].id
  route_table_id = aws_route_table.route_private_db.id
}

# ADD ROUTE TABLE SUBNETS PRIVADAS WORKLOAD
resource "aws_route_table_association" "rta_private_workload" {
  count          = length(var.cidr_block_private_sub_workload)
  subnet_id      = aws_subnet.private_subnet_workload[count.index].id
  route_table_id = aws_route_table.route_private_workload.id
}

# ADD ROUTE TABLE SUBNET PUBLIC
resource "aws_route_table_association" "rta_public_workload" {
  count          = var.create_public_sub == true ? length(var.cidr_block_public_sub_workload) : 0
  subnet_id      = aws_subnet.public_subnet_workload[count.index].id
  route_table_id = aws_route_table.route_public_workload[0].id
}