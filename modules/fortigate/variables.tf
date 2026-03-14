variable "fortigate_host" {
  description = "IP address or hostname of the FortiGate device."
  type        = string
}

variable "api_token" {
    description = "API token for FortiGate access."
    type        = string
    sensitive   = true
}

variable "vpc_cidr" {
  description = "CIDR block of the AWS VPC."
  type        = string
}

variable "fortigate_cidr" {
  description = "CIDR block of the FortiGate network."
  type        = string
}

variable "vpn_tunnel1_address" {
  description = "AWS VPN tunnel 1 address."
  type        = string
}

variable "vpn_tunnel2_address" {
  description = "AWS VPN tunnel 2 address."
  type        = string
}

variable "vpn_tunnel1_preshared_key" {
  description = "Pre-shared key for VPN tunnel 1."
  type        = string
  sensitive   = true
}

variable "vpn_tunnel2_preshared_key" {
  description = "Pre-shared key for VPN tunnel 2."
  type        = string
  sensitive   = true
}
