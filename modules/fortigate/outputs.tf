output "vpn_tunnel1_address" {
  description = "IP address of the VPN tunnel 1 endpoint on FortiGate side."
  value       = var.vpn_tunnel1_address
}

output "vpn_tunnel2_address" {
  description = "IP address of the VPN tunnel 2 endpoint on FortiGate side."
  value       = var.vpn_tunnel2_address
}

output "vpn_tunnel1_preshared_key" {
  description = "Pre-shared key for VPN tunnel 1."
  value       = var.vpn_tunnel1_preshared_key
  sensitive   = true
}

output "vpn_tunnel2_preshared_key" {
  description = "Pre-shared key for VPN tunnel 2."
  value       = var.vpn_tunnel2_preshared_key
  sensitive   = true
}

output "vpn_phase1_name" {
  description = "Name of the VPN Phase 1 interface."
  value       = fortios_vpnipsec_phase1interface.tunnel1.name
}

output "vpn_phase2_name" {
  description = "Name of the VPN Phase 2 interface."
  value       = fortios_vpnipsec_phase2interface.tunnel1.name
}

output "vpn_remote_gw" {
  description = "Remote gateway IP for the VPN."
  value       = fortios_vpnipsec_phase1interface.tunnel1.remote_gw
}

output "phase1_interface_name" {
  description = "Name of the IPsec Phase 1 interface."
  value       = fortios_vpnipsec_phase1interface.tunnel1.name
}

output "phase2_interface_name" {
  description = "Name of the IPsec Phase 2 interface."
  value       = fortios_vpnipsec_phase2interface.tunnel1.name
}

output "fortigate_cidr" {
  description = "CIDR block of the FortiGate network."
  value       = var.fortigate_cidr
}

output "vpc_cidr" {
  description = "CIDR block of the AWS VPC."
  value       = var.vpc_cidr
}