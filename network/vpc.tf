module "prod_app_vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "prod-app-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${data.aws_region.current.name}a"]
  private_subnets = ["10.0.0.0/24"]
  public_subnets  = ["10.0.1.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = local.tags
}

# Define route in default VPC route table: all external traffic must go through the IGW.
resource "aws_route" "default_route_table_route_01" {
  route_table_id         = module.prod_app_vpc.default_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = module.prod_app_vpc.igw_id
}
