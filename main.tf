module "fortigate" {
  source = "./modules/fortigate"

  vpc_cidr                  = var.vpc_cidr
  fortigate_cidr            = var.fortigate_cidr
  fortigate_host            = var.fortigate_host
  api_token = var.api_token
  vpn_tunnel1_address       = module.aws.vpn_tunnel1_address
  vpn_tunnel2_address       = module.aws.vpn_tunnel2_address
  vpn_tunnel1_preshared_key = module.aws.vpn_tunnel1_preshared_key
  vpn_tunnel2_preshared_key = module.aws.vpn_tunnel2_preshared_key
}

module "aws" {
  source = "./modules/aws"

  vpc_cidr             = var.vpc_cidr
  private_subnet_cidrs = var.private_subnet_cidrs
  vpc_name             = var.vpc_name
  customer_gateway_ip  = var.customer_gateway_ip
  fortigate_cidr       = var.fortigate_cidr
  tags = {
    ManagedBy = "terraform"
  }
}


