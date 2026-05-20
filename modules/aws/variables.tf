variable "aws_vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "aws_vpc_name" {
  description = "Name tag for the VPC."
  type        = string
}

variable "ec2_instance_ip" {
  description = "EC2 인스턴스가 가질 IP 주소"
  type        = string
}

variable "ipsec_phase1_enc_algo" {
  description = "Tunnel1에서 사용하는 Phase1 암호화 알고리즘"
  type        = string
}

variable "ipsec_phase1_inter_algo" {
  description = "Tunnel1에서 사용하는 Phase1 무결성 알고리즘"
  type        = string
}

variable "ipsec_phase2_enc_algo" {
  description = "VPN Phase 2 encryption algorithm"
  type        = string
}

variable "ipsec_phase2_inter_algo" {
  description = "VPN Phase 2 integrity algorithm"
  type        = string
}

variable "aws_private_subnet_cidrs" {
  description = "CIDR blocks for private subnets to create inside the VPC."
  type        = list(string)
  validation {
    condition     = length(var.aws_private_subnet_cidrs) < 2
    error_message = "서브넷 개수는 2개 이상 명시하시오. ex) ['10.0.1.0/24', '10.0.2.0/24']"
  }
}

variable "aws_resource_tags" {
  description = "Tags to apply to created resources."
  type        = map(string)
}

variable "fortios_cgw_public_ip" {
  description = "Public IP address of the FortiGate device for Customer Gateway."
  type        = string
}

variable "ipsec_preshared_key" {
  sensitive   = true
  description = "Pre-shared key for both VPN tunnels"
  type        = string
}

variable "ipsec_dh_group" {
  description = "Tunnel에 사용될 DH Group"
  type        = string
}

variable "on_prem_network_cidr" {
  description = "CIDR block of the on-premises network to route traffic to."
  type        = string
}
