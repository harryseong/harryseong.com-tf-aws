nat_instance_ec2_configs = {
  ami_id        = "ami-070801f9b4d12d5dc"
  instance_type = "t2.micro"
  key_name      = "nat-instance-key-pair"
  monitoring    = false

  create_spot_instance      = true
  spot_price                = "0.045"
  spot_type                 = "persistent"
  spot_wait_for_fulfillment = true
}
