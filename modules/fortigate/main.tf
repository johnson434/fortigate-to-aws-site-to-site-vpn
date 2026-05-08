provider "fortios" {
  hostname = var.fortigate_host
  token    = var.api_token
  insecure = true
}

locals {
  tunnel_name = "aws-vpn-tunnel1"
}

resource "fortios_vpnipsec_phase1interface" "tunnel1" {
  name       = local.tunnel_name
  type       = "static"
  interface  = "port1"
  remote_gw  = var.vpn_tunnel1_address
  proposal   = "${var.p1_enc_algo}-${var.p1_inter_algo}"
  authmethod = "psk"
  psksecret  = var.vpn_tunnel1_preshared_key
  comments   = "AWS Site-to-Site VPN Tunnel 1"
  dhgrp      = var.dhgrp
}

resource "fortios_vpnipsec_phase2interface" "tunnel1" {
  name       = "aws-vpn-tunnel1"
  phase1name = fortios_vpnipsec_phase1interface.tunnel1.name
  proposal   = "des-sha1"
  src_subnet = var.vpn_src_subnet
  dst_subnet = var.vpn_dst_subnet
  comments   = "AWS Site-to-Site VPN Tunnel 1 Phase 2"
}

resource "fortios_router_static" "vpn" {
  device = local.tunnel_name

  src    = var.vpn_src_subnet
  dst    = var.vpn_dst_subnet
  status = "enable"
}

# Firewall Policy: VPN to Internal
resource "fortios_firewall_policy" "vpn_to_internal" {
  name     = "vpn-to-internal"
  action   = "accept"
  schedule = "always"

  srcintf {
    name = fortios_vpnipsec_phase1interface.tunnel1.name
  }

  dstintf {
    name = "port3"
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
    name = "port3"
  }

  dstintf {
    name = fortios_vpnipsec_phase2interface.tunnel1.name
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
