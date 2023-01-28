# INTERNET GATEWAY => SUBNETE WORKLOAD
resource "aws_internet_gateway" "ig_workload" {
  vpc_id = aws_vpc.vpc_workload.id

  tags = {
    Name = "${var.vpc_name_workload}"
  }
}

# ELASTIC IP
resource "aws_eip" "eip_workload" {
  count = var.create_public_sub == true ? 1 : 0
  vpc   = true

  depends_on = [aws_internet_gateway.ig_workload]
}

# NAT GATEWAY
resource "aws_nat_gateway" "ng_workload" {
  count         = var.create_public_sub == true ? 1 : 0
  allocation_id = aws_eip.eip_workload[count.index].id
  subnet_id     = aws_subnet.public_subnet_workload[count.index].id

  tags = {
    Name = "PUBLIC-NAT-GATEWAY"
  }

  depends_on = [aws_internet_gateway.ig_workload, aws_eip.eip_workload]
}