# ROUTE TABLE VPC DB SUBNETES PRIVADAS
resource "aws_route_table" "route_private_db" {
  vpc_id = aws_vpc.vpc_db.id

  route {
    cidr_block                = var.cidr_vpc_app
    vpc_peering_connection_id = aws_vpc_peering_connection.px_app_db.id
  }

  tags = {
    Name = "${var.private_subnet_db_name}"
  }
}

# ROUTE TABLE VPC app SUBNETES PRIVADAS
resource "aws_route_table" "route_private_app" {
  vpc_id = aws_vpc.vpc_app.id

  route {
    cidr_block                = var.cidr_vpc_db
    vpc_peering_connection_id = aws_vpc_peering_connection.px_app_db.id
  }

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ng_app[0].id
  }

  tags = {
    Name = "${var.private_subnet_app_name}"
  }
}

# ROUTE TABLE VPC app SUBNETES PUBLICAS
resource "aws_route_table" "route_public_app" {
  count  = var.create_public_sub == true ? 1 : 0
  vpc_id = aws_vpc.vpc_app.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig_app.id
  }

  tags = {
    Name = "${var.public_subnet_app_name}"
  }
}

# ADD ROUTE TABLE SUBNETS PRIVADAS DB
resource "aws_route_table_association" "rta_private_db" {
  count          = length(var.cidr_block_private_sub_db)
  subnet_id      = aws_subnet.private_subnet_db[count.index].id
  route_table_id = aws_route_table.route_private_db.id
}

# ADD ROUTE TABLE SUBNETS PRIVADAS app
resource "aws_route_table_association" "rta_private_app" {
  count          = length(var.cidr_block_private_sub_app)
  subnet_id      = aws_subnet.private_subnet_app[count.index].id
  route_table_id = aws_route_table.route_private_app.id
}

# ADD ROUTE TABLE SUBNET PUBLIC
resource "aws_route_table_association" "rta_public_app" {
  count          = var.create_public_sub == true ? length(var.cidr_block_public_sub_app) : 0
  subnet_id      = aws_subnet.public_subnet_app[count.index].id
  route_table_id = aws_route_table.route_public_app[0].id
}