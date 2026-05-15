locals {
  tunnel1_name = "aws-vpn-tunnel1"
  tunnel2_name = "aws-vpn-tunnel2"
}

resource "fortios_vpnipsec_phase1interface" "tunnel1" {
  name       = local.tunnel1_name
  type       = "static"
  interface  = var.fortios_external_interface
  remote_gw  = var.aws_vpn_tunnel1_address
  proposal   = "${var.ipsec_phase1_enc_algo}-${var.ipsec_phase1_inter_algo}"
  authmethod = "psk"
  psksecret  = var.aws_vpn_tunnel1_psk
  comments   = "AWS Site-to-Site VPN Tunnel 1"
  dhgrp      = var.ipsec_dh_group
}

resource "fortios_vpnipsec_phase2interface" "tunnel1" {
  name       = local.tunnel1_name
  phase1name = fortios_vpnipsec_phase1interface.tunnel1.name
  proposal   = "${var.ipsec_phase2_enc_algo}-${var.ipsec_phase2_inter_algo}"
  src_subnet = "0.0.0.0/0"
  dst_subnet = "0.0.0.0/0"
  comments   = "AWS Site-to-Site VPN Tunnel 1 Phase 2"
}

resource "fortios_vpnipsec_phase1interface" "tunnel2" {
  name       = local.tunnel2_name
  type       = "static"
  interface  = var.fortios_external_interface
  remote_gw  = var.aws_vpn_tunnel2_address
  proposal   = "${var.ipsec_phase1_enc_algo}-${var.ipsec_phase1_inter_algo}"
  authmethod = "psk"
  psksecret  = var.aws_vpn_tunnel2_psk
  comments   = "AWS Site-to-Site VPN Tunnel 2"
  dhgrp      = var.ipsec_dh_group
}

resource "fortios_vpnipsec_phase2interface" "tunnel2" {
  name       = local.tunnel2_name
  phase1name = fortios_vpnipsec_phase1interface.tunnel2.name
  proposal   = "${var.ipsec_phase2_enc_algo}-${var.ipsec_phase2_inter_algo}"
  src_subnet = "0.0.0.0/0"
  dst_subnet = "0.0.0.0/0"
  comments   = "AWS Site-to-Site VPN Tunnel 2 Phase 2"
}

resource "fortios_router_static" "vpn1" {
  device = local.tunnel1_name
  dst    = var.vpn_remote_subnet_cidr
  status = "enable"
}

resource "fortios_router_static" "vpn2" {
  device   = local.tunnel2_name
  dst      = var.vpn_remote_subnet_cidr
  status   = "enable"
  priority = 10
}

# Firewall Policy: VPN to Internal
resource "fortios_firewall_policy" "vpn_to_internal" {
  name     = "vpn-to-internal"
  action   = "accept"
  schedule = "always"

  srcintf {
    name = fortios_vpnipsec_phase1interface.tunnel1.name
  }
  srcintf {
    name = fortios_vpnipsec_phase1interface.tunnel2.name
  }

  dstintf {
    name = var.fortios_internal_interface
  }

  srcaddr {
    name = "all"
  }

  dstaddr {
    name = "all"
  }

  service {
    name = "ALL"
  }
}

# Firewall Policy: Internal to VPN
resource "fortios_firewall_policy" "internal_to_vpn" {
  name       = "internal-to-vpn"
  action     = "accept"
  schedule   = "always"
  logtraffic = "all"
  comments   = "Allow traffic from internal network to VPN"

  srcintf {
    name = var.fortios_internal_interface
  }

  dstintf {
    name = fortios_vpnipsec_phase2interface.tunnel1.name
  }
  dstintf {
    name = fortios_vpnipsec_phase2interface.tunnel2.name
  }

  srcaddr {
    name = "all"
  }

  dstaddr {
    name = "all"
  }

  service {
    name = "ALL"
  }
}
