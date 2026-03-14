provider "fortios" {
  hostname = var.fortigate_host
  token = var.api_token
  insecure = true
}

resource "fortios_vpnipsec_phase1" "tunnel1" {
  name       = "aws-vpn-tunnel1"
  type       = "static"
  interface  = "port1"
  remote_gw  = var.vpn_tunnel1_address
  psksecret  = var.vpn_tunnel1_preshared_key
  proposal   = "aes256-sha256 aes256-sha1 aes128-sha256 aes128-sha1"
  authmethod = "psk"
  comments   = "AWS Site-to-Site VPN Tunnel 1"
}

resource "fortios_vpnipsec_phase2" "tunnel1" {
  name       = "aws-vpn-tunnel1-p2"
  phase1name = fortios_vpnipsec_phase1.tunnel1.name
  proposal   = "aes256-sha256 aes256-sha1 aes128-sha256 aes128-sha1"
  src_subnet = var.fortigate_cidr
  dst_subnet = var.vpc_cidr
  comments   = "AWS Site-to-Site VPN Tunnel 1 Phase 2"
}

# Firewall Policy: VPN to Internal
resource "fortios_firewall_policy" "vpn_to_internal" {
  name     = "vpn-to-internal"
  action   = "accept"
  schedule = "always"
  logtraffic = "all"
  comments = "Allow traffic from VPN to internal network"

  srcintf {
    name = fortios_vpnipsec_phase2.tunnel1.name
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
  name     = "internal-to-vpn"
  action   = "accept"
  schedule = "always"
  logtraffic = "all"
  comments = "Allow traffic from internal network to VPN"

  srcintf {
    name = "port3"
  }

  dstintf {
    name = fortios_vpnipsec_phase2.tunnel1.name
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