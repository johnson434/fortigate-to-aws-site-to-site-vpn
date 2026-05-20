locals {
  ipsec_phase1_enc_algo   = "AES128"
  ipsec_phase1_inter_algo = "SHA1"
  ipsec_phase2_enc_algo   = "AES128"
  ipsec_phase2_inter_algo = "SHA1"
  ipsec_dh_group          = 14
}

provider "fortios" {
  hostname = var.fortios_api_hostname
  token    = var.fortios_api_token
  insecure = true
}

module "fortigate" {
  source = "./modules/fortigate"

  fortios_external_interface = var.fortios_external_interface
  fortios_internal_interface = var.fortios_internal_interface
  vpn_local_subnet_cidr      = var.on_prem_network_cidr
  vpn_remote_subnet_cidr     = var.aws_vpc_cidr
  ipsec_dh_group             = local.ipsec_dh_group
  aws_vpn_tunnel1_address    = module.aws.vpn_tunnel1_address
  aws_vpn_tunnel1_psk        = module.aws.vpn_tunnel1_preshared_key
  ipsec_phase1_enc_algo      = lower(local.ipsec_phase1_enc_algo)
  ipsec_phase1_inter_algo    = lower(local.ipsec_phase1_inter_algo)
  ipsec_phase2_enc_algo      = lower(local.ipsec_phase2_enc_algo)
  ipsec_phase2_inter_algo    = lower(local.ipsec_phase2_inter_algo)
  aws_vpn_tunnel2_address    = module.aws.vpn_tunnel2_address
  aws_vpn_tunnel2_psk        = module.aws.vpn_tunnel2_preshared_key
}

module "aws" {
  source = "./modules/aws"

  aws_vpc_cidr             = var.aws_vpc_cidr
  on_prem_network_cidr     = var.on_prem_network_cidr
  aws_private_subnet_cidrs = var.aws_private_subnet_cidrs
  aws_vpc_name             = var.aws_vpc_name
  fortios_cgw_public_ip    = var.fortios_cgw_public_ip
  ipsec_preshared_key      = var.ipsec_preshared_key
  ipsec_phase1_enc_algo    = local.ipsec_phase1_enc_algo

  ipsec_phase1_inter_algo = local.ipsec_phase1_inter_algo
  ipsec_phase2_enc_algo   = local.ipsec_phase2_enc_algo
  ipsec_phase2_inter_algo = local.ipsec_phase2_inter_algo
  ipsec_dh_group          = local.ipsec_dh_group
  ec2_instance_ip         = var.aws_ec2_instance_ip

  aws_resource_tags = {
    ManagedBy = "terraform"
  }
}
