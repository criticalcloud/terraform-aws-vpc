# ROUTE TABLE VPC DB SUBNETES PRIVADAS
resource "aws_route_table" "route_private_db" {
  count  = var.create_vpc_db == true ? 1 : 0
  vpc_id = aws_vpc.vpc_db[count.index].id

  tags = {
    Name = "${var.private_subnet_db_name}"
  }
}

resource "aws_route" "route_private_db_01" {
  count = var.create_vpc_db == true ? 1 : 0
  route_table_id            = aws_route_table.route_private_db[count.index].id
  destination_cidr_block    = var.cidr_vpc_app
  vpc_peering_connection_id =  aws_vpc_peering_connection.px_app_db[count.index].id
}

# ROUTE TABLE VPC app SUBNETES PRIVADAS
resource "aws_route_table" "route_private_app" {
  vpc_id = aws_vpc.vpc_app.id

  tags = {
    Name = "${var.private_subnet_app_name}"
  }
}

resource "aws_route" "route_private_app_01" {
  route_table_id            = aws_route_table.route_private_app.id
  destination_cidr_block    = var.cidr_vpc_db
  vpc_peering_connection_id = aws_vpc_peering_connection.px_app_db[0].id
}

resource "aws_route" "route_private_app_02" {
  route_table_id            = aws_route_table.route_private_app.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id            = aws_nat_gateway.ng_app[0].id
}

# ROUTE TABLE VPC app SUBNETES PUBLICAS
resource "aws_route_table" "route_public_app" {
  count  = var.create_public_sub == true ? 1 : 0
  vpc_id = aws_vpc.vpc_app.id

  tags = {
    Name = "${var.public_subnet_app_name}"
  }
}

resource "aws_route" "route_public_app_01" {
  count  = var.create_public_sub == true ? 1 : 0
  route_table_id            = aws_route_table.route_public_app[count.index].id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.ig_app.id
}

# ADD ROUTE TABLE SUBNETS PRIVADAS DB
resource "aws_route_table_association" "rta_private_db" {
  count          = var.create_vpc_db == true ? length(var.cidr_block_private_sub_db) : 0
  subnet_id      = aws_subnet.private_subnet_db[count.index].id
  route_table_id = aws_route_table.route_private_db[count.index].id
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