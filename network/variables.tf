variable "env" {
  description = "Environment. Values: ['dev', 'test', 'prod', 'shared']"
  type        = string
}

variable "vpc_configs" {
  description = "Map of input values for VPC creation."
  type        = map(any)
}

variable "subnet_configs" {
  description = "Map of input values for subnet creation."
  type        = map(any)
}

variable "nat_instance_ec2_configs" {
  description = "Map of input values for EC2 module."
  type        = map(any)
}
