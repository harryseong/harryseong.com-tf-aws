module "network" {
  source = "./network"
  env    = "shared"

  vpc_configs              = var.vpc_configs
  subnet_configs           = var.subnet_configs
  nat_instance_ec2_configs = var.nat_instance_ec2_configs
}

module "route53_public_hosted_zone" {
  source = "./route53_public_hosted_zone"
  env    = "shared"

  domain_name = var.domain_name
}

module "codestarconnections" {
  source = "./codestarconnections"
  env    = "shared"
}

module "frontend" {
  for_each = toset(["test", "prod"])
  source   = "./frontend"
  env      = each.value

  project_name            = var.project_name
  domain_name             = var.domain_name
  public_hosted_zone_id   = module.route53_public_hosted_zone.zone_id
  codestarconnections_arn = module.codestarconnections.github_connection_arn
}
