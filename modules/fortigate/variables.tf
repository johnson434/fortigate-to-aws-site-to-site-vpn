variable "aws_vpn_tunnel1_address" {
  description = "AWS VPN tunnel 1 address."
  type        = string
}

variable "ipsec_dh_group" {
  description = "Tunnel1과 Tunnel2에서 사용할 DH"
  type        = string
}

variable "aws_vpn_tunnel2_address" {
  description = "AWS VPN tunnel 2 address."
  type        = string
}

variable "vpn_local_subnet_cidr" {
  type        = string
  description = "VPN Tunnel의 local subnet"
}

variable "vpn_remote_subnet_cidr" {
  type        = string
  description = "VPN Tunnel의 remote subnet"
}

variable "aws_vpn_tunnel1_psk" {
  description = "Pre-shared key for VPN tunnel 1."
  type        = string
  sensitive   = true
}

variable "ipsec_phase1_enc_algo" {
  description = "Tunnel1에서 사용하는 Phase1 암호화 알고리즘"
  type        = string
}

variable "ipsec_phase1_inter_algo" {
  description = "Tunnel1에서 사용하는 Phase1 무결성 알고리즘"
  type        = string
}

variable "aws_vpn_tunnel2_psk" {
  description = "Pre-shared key for VPN tunnel 2."
  type        = string
  sensitive   = true
}

variable "ipsec_phase2_enc_algo" {
  description = "Phase 2 encryption algorithm"
  type        = string
  default     = "aes128"
}

variable "ipsec_phase2_inter_algo" {
  description = "Phase 2 integrity algorithm"
  type        = string
  default     = "sha1"
}

variable "fortios_external_interface" {
  description = "External interface for VPN"
  type        = string
}

variable "fortios_internal_interface" {
  description = "Internal interface for firewall policies"
  type        = string
}
