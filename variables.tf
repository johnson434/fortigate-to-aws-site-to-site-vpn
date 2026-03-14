variable "vpc_cidr" {
  description = "CIDR block to create the VPC in."
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for the private subnets to create within the VPC."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "vpc_name" {
  description = "Name tag for the VPC and related resources."
  type        = string
  default     = "fortigate-vpc"
}

variable "customer_gateway_ip" {
  description = "Public IP address of the FortiGate device for Customer Gateway."
  type        = string
}

variable "fortigate_cidr" {
  description = "CIDR block of the FortiGate network to route traffic to."
  type        = string
  default     = "192.168.0.0/16"
}

variable "fortigate_host" {
  description = "IP address or hostname of the FortiGate device."
  type        = string
}

variable "api_token" {
    description = "API token for FortiGate access."
    type        = string
    sensitive   = true
}