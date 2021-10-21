variable "env" {
  description = "Environment. Values: ['dev', 'test', 'prod', 'shared']"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID."
  type        = string
}

variable "public_subnets_ids" {
  description = "List of public subnets IDs."
  type        = list(string)
}

variable "private_subnets_cidr_blocks" {
  description = "List of private subnets CIDR blocks."
  type        = list(string)
}

variable "ec2_configs" {
  description = "Map of input values for EC2 module."
  type        = map(any)
}

variable "private_route_table_ids" {
  description = "List of private subnets route table IDs."
  type        = list(string)
}
