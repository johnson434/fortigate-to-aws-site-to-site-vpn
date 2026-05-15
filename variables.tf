variable "aws_vpc_cidr" {
  description = "CIDR block to create the VPC in."
  type        = string
  default     = "10.0.0.0/16"
}

variable "aws_private_subnet_cidrs" {
  description = "CIDR blocks for the private subnets to create within the VPC."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "aws_vpc_name" {
  description = "Name tag for the VPC and related resources."
  type        = string
  default     = "fortigate-vpc"
}

variable "fortios_cgw_public_ip" {
  description = "Public IP address of the FortiGate device for Customer Gateway."
  type        = string
}

variable "on_prem_network_cidr" {
  description = "CIDR block of the on-premises network to route traffic to."
  type        = string
}

variable "fortios_api_hostname" {
  description = "IP address or hostname of the FortiGate device."
  type        = string
}

variable "fortios_api_token" {
  description = "API token for FortiGate access."
  type        = string
  sensitive   = true
}

variable "ipsec_preshared_key" {
  description = "Shared Pre-shared key for both AWS VPN tunnels"
  type        = string
  sensitive   = true
}

