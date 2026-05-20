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

variable "aws_ec2_instance_ip" {
  description = "VPN 터널 통신 테스트를 위해 만들 EC2 인스턴스가 가질 IP 주소"
  type        = string
}

variable "fortios_external_interface" {
  description = "FortiGate가 IPsec을 맺을 인터페이스명"
  type        = string
}

variable "fortios_internal_interface" {
  description = "On-premise의 VPN을 통해 접근할 내부 대역으로 향하는 인터페이스명"
  type        = string
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

