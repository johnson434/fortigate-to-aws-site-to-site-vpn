# AWS Module Test: VPC Creation
# Run with: terraform test

run "create_vpc_test" {
  command = plan

  variables {
    aws_vpc_cidr             = "10.0.0.0/16"
    aws_private_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
    aws_vpc_name             = "test-vpc"
    fortios_cgw_public_ip    = "203.0.113.1" # Example public IP
    on_prem_network_cidr     = "192.168.0.0/16"
    ipsec_preshared_key      = "test_preshared_key_12345"
    ipsec_dh_group           = "14"
    ipsec_phase1_enc_algo    = "AES128"
    ipsec_phase1_inter_algo  = "SHA1"
    ipsec_phase2_enc_algo    = "AES128"
    ipsec_phase2_inter_algo  = "SHA1"

    aws_resource_tags = {
      ManagedBy = "terraform-test"
    }
  }

  assert {
    condition     = aws_vpc.main.cidr_block == "10.0.0.0/16"
    error_message = "VPC CIDR block did not match expected value"
  }

  assert {
    condition     = length(aws_subnet.private) == 2
    error_message = "Did not create expected number of private subnets"
  }

  assert {
    condition     = aws_customer_gateway.fortigate.ip_address == "203.0.113.1"
    error_message = "Customer Gateway IP address did not match expected value"
  }
}
