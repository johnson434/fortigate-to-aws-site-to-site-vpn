terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region                      = "us-east-1"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}

module "aws" {
  source = "../"

  vpc_cidr             = "10.0.0.0/16"
  private_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  vpc_name             = "test-vpc"
  customer_gateway_ip  = "203.0.113.1"  # Example public IP
  fortigate_cidr       = "192.168.0.0/16"

  tags = {
    ManagedBy = "terraform-test"
  }
}


test "vpc is created" {
  condition     = module.aws.vpc_id != ""
  error_message = "Expected module to create a VPC and return vpc_id"
}

test "creates two private subnets" {
  condition     = length(module.aws.private_subnet_ids) == 2
  error_message = "Expected module to create two private subnets"
}

test "vpn connection is created" {
  condition     = module.aws.vpn_connection_id != ""
  error_message = "Expected module to create a VPN connection"
}

test "customer gateway is created" {
  condition     = module.aws.customer_gateway_id != ""
  error_message = "Expected module to create a Customer Gateway"
}

test "vpn gateway is created" {
  condition     = module.aws.vpn_gateway_id != ""
  error_message = "Expected module to create a VPN Gateway"
}

