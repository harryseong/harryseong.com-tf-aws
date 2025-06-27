module "nat_instance" {
  count  = 0 # No NAT instance needed anymore.
  source = "./nat_instance"
  env    = var.env

  vpc_id                      = module.prod_app_vpc.vpc_id
  public_subnets_ids          = module.prod_app_vpc.public_subnets
  private_subnets_cidr_blocks = module.prod_app_vpc.private_subnets_cidr_blocks
  private_route_table_ids     = module.prod_app_vpc.private_route_table_ids

  ec2_configs = var.nat_instance_ec2_configs
}
