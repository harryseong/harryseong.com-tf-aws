module "nat_instance" {
  count   = 1
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "3.2.0"

  name = "nat-instance-${count.index + 1}"

  create_spot_instance      = var.ec2_configs.create_spot_instance
  spot_price                = var.ec2_configs.spot_price
  spot_type                 = var.ec2_configs.spot_type
  spot_wait_for_fulfillment = var.ec2_configs.spot_wait_for_fulfillment

  ami                    = var.ec2_configs.ami_id
  instance_type          = var.ec2_configs.instance_type
  iam_instance_profile   = aws_iam_instance_profile.nat_instance_profile.name
  key_name               = var.ec2_configs.key_name
  source_dest_check      = false
  monitoring             = var.ec2_configs.monitoring
  vpc_security_group_ids = [aws_security_group.nat_instance_sg.id]
  subnet_id              = var.public_subnets_ids[count.index % length(var.public_subnets_ids)]

  user_data = file("./network/nat_instance/bootstrap.sh")

  tags = {
    Name        = "nat-instance-${count.index + 1}"
    Environment = var.env
  }
}
