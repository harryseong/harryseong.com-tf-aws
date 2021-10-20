resource "aws_security_group" "nat_instance_sg" {
  name        = "nat-instance-sg"
  description = "NAT instance security group."
  vpc_id      = var.vpc_id

  tags = {
    Name        = "nat-instance-sg"
    Terraform   = "true"
    Environment = "prod"
  }
}

resource "aws_security_group_rule" "sg-ingress-01" {
  type              = "ingress"
  description       = "Ingress ICMP traffic for ping."
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nat_instance_sg.id
}

resource "aws_security_group_rule" "sg-ingress-02" {
  type              = "ingress"
  description       = "Ingress HTTP traffic."
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = var.private_subnets_cidr_blocks
  security_group_id = aws_security_group.nat_instance_sg.id
}

resource "aws_security_group_rule" "sg-ingress-03" {
  type              = "ingress"
  description       = "Ingress HTTPS traffic."
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.private_subnets_cidr_blocks
  security_group_id = aws_security_group.nat_instance_sg.id
}

resource "aws_security_group_rule" "sg-ingress-04" {
  type              = "ingress"
  description       = "Ingress SSH traffic."
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.private_subnets_cidr_blocks
  security_group_id = aws_security_group.nat_instance_sg.id
}

resource "aws_security_group_rule" "sg-egress-01" {
  type              = "egress"
  description       = "Egress HTTP traffic."
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nat_instance_sg.id
}

resource "aws_security_group_rule" "sg-egress-02" {
  type              = "egress"
  description       = "Egress HTTPS traffic."
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nat_instance_sg.id
}

resource "aws_security_group_rule" "sg-egress-03" {
  type              = "egress"
  description       = "Egress SSH traffic."
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nat_instance_sg.id
}
