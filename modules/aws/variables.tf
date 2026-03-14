variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name tag for the VPC."
  type        = string
  default     = "fortigate-vpc"
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets to create inside the VPC."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "tags" {
  description = "Tags to apply to created resources."
  type        = map(string)
  default     = {}
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

