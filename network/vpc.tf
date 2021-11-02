module "prod_app_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                        = var.vpc_configs.name
  cidr                        = var.vpc_configs.cidr
  enable_nat_gateway          = var.vpc_configs.enable_nat_gateway
  enable_vpn_gateway          = var.vpc_configs.enable_vpn_gateway
  default_security_group_tags = { "Name" = "default" }

  azs                 = [for az in var.subnet_configs.azs : format("%s%s", data.aws_region.current.name, az)]
  private_subnets     = var.subnet_configs.private_subnet_cidrs
  private_subnet_tags = { "Tier" = "private" }
  public_subnets      = var.subnet_configs.public_subnet_cidrs
  public_subnet_tags  = { "Tier" = "public" }

  tags = local.tags
}

# Define route in default VPC route table: all external traffic must go through the IGW.
resource "aws_route" "default_route_table_route_01" {
  route_table_id         = module.prod_app_vpc.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = module.prod_app_vpc.igw_id
}
