output "vpc_id" {
  value = aws_vpc.main.id
}

output "private_subnet_ids" {
  value = values(aws_subnet.private)[*].id
}

output "private_subnet_cidrs" {
  value = values(aws_subnet.private)[*].cidr_block
}

output "vpn_connection_id" {
  value = aws_vpn_connection.main.id
}

output "customer_gateway_id" {
  value = aws_customer_gateway.fortigate.id
}

output "vpn_gateway_id" {
  value = aws_vpn_gateway.main.id
}

output "vpn_tunnel1_address" {
  value = aws_vpn_connection.main.tunnel1_address
}

output "vpn_tunnel2_address" {
  value = aws_vpn_connection.main.tunnel2_address
}

output "vpn_tunnel1_preshared_key" {
  value     = aws_vpn_connection.main.tunnel1_preshared_key
  sensitive = true
}

output "vpn_tunnel2_preshared_key" {
  value     = aws_vpn_connection.main.tunnel2_preshared_key
  sensitive = true
}


