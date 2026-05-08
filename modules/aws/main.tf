locals {
  private_subnet_cidrs = zipmap(range(length(var.aws_private_subnet_cidrs)), var.aws_private_subnet_cidrs)
}

resource "aws_vpc" "main" {
  cidr_block           = var.aws_vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge({
    Name = var.aws_vpc_name
  }, var.aws_resource_tags)
}

resource "aws_subnet" "private" {
  for_each = local.private_subnet_cidrs

  vpc_id     = aws_vpc.main.id
  cidr_block = each.value

  tags = merge({
    Name = "${var.aws_vpc_name}-private-${each.key}"
  }, var.aws_resource_tags)
}

resource "aws_vpn_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge({
    Name = "${var.aws_vpc_name}-vgw"
  }, var.aws_resource_tags)
}

resource "aws_customer_gateway" "fortigate" {
  bgp_asn    = 65000
  ip_address = var.fortios_cgw_public_ip
  type       = "ipsec.1"

  tags = merge({
    Name = "fortigate-cgw"
  }, var.aws_resource_tags)
}

resource "aws_vpn_connection" "main" {
  vpn_gateway_id                       = aws_vpn_gateway.main.id
  customer_gateway_id                  = aws_customer_gateway.fortigate.id
  type                                 = "ipsec.1"
  static_routes_only                   = true
  tunnel1_preshared_key                = var.ipsec_preshared_key
  tunnel2_preshared_key                = var.ipsec_preshared_key
  local_ipv4_network_cidr              = local.private_subnet_cidrs[0]
  
  # Tunnel 1 Algorithms
  tunnel1_phase1_dh_group_numbers      = [var.ipsec_dh_group]
  tunnel1_phase1_encryption_algorithms = [var.ipsec_phase1_enc_algo]
  tunnel1_phase1_integrity_algorithms  = [var.ipsec_phase1_inter_algo]
  tunnel1_phase2_encryption_algorithms = [var.ipsec_phase2_enc_algo]
  tunnel1_phase2_integrity_algorithms  = [var.ipsec_phase2_inter_algo]

  # Tunnel 2 Algorithms (Unified with Tunnel 1)
  tunnel2_phase1_dh_group_numbers      = [var.ipsec_dh_group]
  tunnel2_phase1_encryption_algorithms = [var.ipsec_phase1_enc_algo]
  tunnel2_phase1_integrity_algorithms  = [var.ipsec_phase1_inter_algo]
  tunnel2_phase2_encryption_algorithms = [var.ipsec_phase2_enc_algo]
  tunnel2_phase2_integrity_algorithms  = [var.ipsec_phase2_inter_algo]

  tags = merge({
    Name = "${var.aws_vpc_name}-vpn"
  }, var.aws_resource_tags)
}

resource "aws_vpn_connection_route" "fortigate" {
  destination_cidr_block = var.on_prem_network_cidr
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
  destination_cidr_block = var.on_prem_network_cidr
  gateway_id             = aws_vpn_gateway.main.id
}
