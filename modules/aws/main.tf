locals {
  private_subnet_cidrs = zipmap(range(length(var.private_subnet_cidrs)), var.private_subnet_cidrs)
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge({
    Name = var.vpc_name
  }, var.tags)
}

resource "aws_subnet" "private" {
  for_each = local.private_subnet_cidrs

  vpc_id     = aws_vpc.main.id
  cidr_block = each.value

  tags = merge({
    Name = "${var.vpc_name}-private-${each.key}"
  }, var.tags)
}

resource "aws_vpn_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge({
    Name = "${var.vpc_name}-vgw"
  }, var.tags)
}

resource "aws_customer_gateway" "fortigate" {
  bgp_asn    = 65000
  ip_address = var.customer_gateway_ip
  type       = "ipsec.1"

  tags = merge({
    Name = "fortigate-cgw"
  }, var.tags)
}

resource "aws_vpn_connection" "main" {
  vpn_gateway_id      = aws_vpn_gateway.main.id
  customer_gateway_id = aws_customer_gateway.fortigate.id
  type                = "ipsec.1"
  static_routes_only  = true

  tags = merge({
    Name = "${var.vpc_name}-vpn"
  }, var.tags)
}

resource "aws_vpn_connection_route" "fortigate" {
  destination_cidr_block = var.fortigate_cidr
  vpn_connection_id      = aws_vpn_connection.main.id
}

data "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  filter {
    name   = "association.main"
    values = ["true"]
  }
}

resource "aws_route" "fortigate" {
  route_table_id         = data.aws_route_table.main.id
  destination_cidr_block = var.fortigate_cidr
  gateway_id             = aws_vpn_gateway.main.id
}

