# INTERNET GATEWAY => SUBNETE app
resource "aws_internet_gateway" "ig_app" {
  vpc_id = aws_vpc.vpc_app.id

  tags = {
    Name = "${var.vpc_name_app}"
  }
}

# ELASTIC IP
resource "aws_eip" "eip_app" {
  count = var.create_public_sub == true ? 1 : 0
  vpc   = true

  depends_on = [aws_internet_gateway.ig_app]
}

# NAT GATEWAY
resource "aws_nat_gateway" "ng_app" {
  count         = var.create_public_sub == true ? 1 : 0
  allocation_id = aws_eip.eip_app[count.index].id
  subnet_id     = aws_subnet.public_subnet_app[count.index].id

  tags = {
    Name = "public-nat-gateway"
  }

  depends_on = [aws_internet_gateway.ig_app, aws_eip.eip_app]
}