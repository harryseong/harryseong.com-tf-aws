module "network" {
  source = "./network"
}

module "nat_instance" {
  count  = 1
  source = "./nat_instance"

  vpc_id                      = module.network.prod_app_vpc.id
  public_subnets_ids          = module.network.prod_app_vpc.public_subnets_ids
  private_subnets_cidr_blocks = module.network.prod_app_vpc.private_subnets_cidr_blocks
  private_route_table_ids     = module.network.prod_app_vpc.private_route_table_ids

  ec2_configs = var.nat_instance_ec2_configs
}

module "frontend" {
  count  = 1
  source = "./frontend"
}
