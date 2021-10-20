# Define route in private subnet route table: all external traffic must go through NAT instance in public subnet.
resource "aws_route" "private_route_table_route_01" {
  count = length(var.private_route_table_ids)

  route_table_id         = var.private_route_table_ids[count.index]
  destination_cidr_block = "0.0.0.0/0"
  instance_id            = module.nat_instance[0].spot_instance_id
}
