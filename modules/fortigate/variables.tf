variable "fortigate_host" {
  description = "IP address or hostname of the FortiGate device."
  type        = string
}

variable "api_token" {
  description = "API token for FortiGate access."
  type        = string
  sensitive   = true
}

variable "vpn_tunnel1_address" {
  description = "AWS VPN tunnel 1 address."
  type        = string
}

variable "dhgrp" {
  description = "Tunnel1과 Tunnel2에서 사용할 DH"
  type        = string
}

variable "vpn_tunnel2_address" {
  description = "AWS VPN tunnel 2 address."
  type        = string
}

variable "vpn_src_subnet" {
  type        = string
  description = "VPN Tunnel의 local subnet"
}

variable "vpn_dst_subnet" {
  type        = string
  description = "VPN Tunnel의 remote subnet"
}

variable "vpn_tunnel1_preshared_key" {
  description = "Pre-shared key for VPN tunnel 1."
  type        = string
  sensitive   = true
}

variable "p1_enc_algo" {
  description = "Tunnel1에서 사용하는 Phase1 암호화 알고리즘"
  type        = string
}

variable "p1_inter_algo" {
  description = "Tunnel1에서 사용하는 Phase1 무결성 알고리즘"
  type        = string
}

variable "vpn_tunnel2_preshared_key" {
  description = "Pre-shared key for VPN tunnel 2."
  type        = string
  sensitive   = true
}
