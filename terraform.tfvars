project_name = "harryseong"
domain_name  = "harryseong.com"

nat_instance_ec2_configs = {
  ami_id        = "ami-070801f9b4d12d5dc"
  instance_type = "t3.nano"
  key_name      = "nat-instance-key-pair"
  monitoring    = false

  create_spot_instance      = true
  spot_price                = "0.035"
  spot_type                 = "persistent"
  spot_wait_for_fulfillment = true
}

vpc_configs = {
  name               = "prod-app-vpc"
  cidr               = "10.0.0.0/16"
  enable_nat_gateway = false
  enable_vpn_gateway = false
}

subnet_configs = {
  # azs                  = ["a", "b", "c"]
  # private_subnet_cidrs = ["10.0.0.0/27", "10.0.0.32/27", "10.0.0.64/27"]
  # public_subnet_cidrs  = ["10.0.1.0/28"]
  azs                  = ["a", "b"]
  private_subnet_cidrs = ["10.0.0.0/24"]
  public_subnet_cidrs  = ["10.0.1.0/24"]
}
