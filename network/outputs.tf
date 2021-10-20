output "prod_app_vpc" {
  description = "VPC details for prod-app-vpc."
  value = {
    id                          = module.prod_app_vpc.vpc_id
    name                        = module.prod_app_vpc.name
    private_subnets_ids         = module.prod_app_vpc.private_subnets
    private_subnets_cidr_blocks = module.prod_app_vpc.private_subnets_cidr_blocks
    public_subnets_ids          = module.prod_app_vpc.public_subnets
    public_subnets_cidr_blocks  = module.prod_app_vpc.public_subnets_cidr_blocks
    private_route_table_ids     = module.prod_app_vpc.private_route_table_ids
  }
}
