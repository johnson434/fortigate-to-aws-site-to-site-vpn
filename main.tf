locals {
  p1_enc_algo   = "AES128"
  p1_inter_algo = "SHA1"
  dhgrp         = 14
}

module "fortigate" {
  source = "./modules/fortigate"

  vpn_src_subnet            = var.fortigate_cidr
  vpn_dst_subnet            = var.vpc_cidr
  dhgrp                     = local.dhgrp
  fortigate_host            = var.fortigate_host
  api_token                 = var.api_token
  vpn_tunnel1_address       = module.aws.vpn_tunnel1_address
  vpn_tunnel1_preshared_key = module.aws.vpn_tunnel1_preshared_key
  #  p1_enc_algo       = lower(local.p1_enc_algo)
  #  p1_inter_algo     = lower(local.p1_inter_algo)
  p1_enc_algo   = "des"
  p1_inter_algo = "sha1"

  vpn_tunnel2_address       = module.aws.vpn_tunnel2_address
  vpn_tunnel2_preshared_key = module.aws.vpn_tunnel2_preshared_key
}

module "aws" {
  source = "./modules/aws"

  vpc_cidr              = var.vpc_cidr
  fortigate_cidr        = var.fortigate_cidr
  private_subnet_cidrs  = var.private_subnet_cidrs
  vpc_name              = var.vpc_name
  customer_gateway_ip   = var.customer_gateway_ip
  tunnel1_preshared_key = var.tunnel1_preshared_key
  p1_enc_algo           = local.p1_enc_algo
  p1_inter_algo         = local.p1_inter_algo
  dhgrp                 = local.dhgrp

  tags = {
    ManagedBy = "terraform"
  }
}
