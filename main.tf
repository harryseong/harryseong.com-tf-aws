module "network" {
  source = "./network"
  env    = "shared"
}

module "nat_instance" {
  count  = 1
  source = "./nat_instance"
  env    = "shared"

  vpc_id                      = module.network.prod_app_vpc.id
  public_subnets_ids          = module.network.prod_app_vpc.public_subnets_ids
  private_subnets_cidr_blocks = module.network.prod_app_vpc.private_subnets_cidr_blocks
  private_route_table_ids     = module.network.prod_app_vpc.private_route_table_ids

  ec2_configs = var.nat_instance_ec2_configs
}

module "route53_public_hosted_zone" {
  source = "./route53_public_hosted_zone"
  env    = "shared"
}

module "codestarconnections" {
  source = "./codestarconnections"
  env    = "shared"
}

module "frontend" {
  for_each = toset(["test"])
  source   = "./frontend"
  env      = each.value

  project_name            = var.project_name
  domain_name             = var.domain_name
  public_hosted_zone_id   = module.route53_public_hosted_zone.zone_id
  codestarconnections_arn = module.codestarconnections.github_connection_arn
}
