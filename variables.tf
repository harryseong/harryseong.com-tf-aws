variable "project_name" {
  description = "Project name. Ex: 'harryseong'"
  type        = string
}

variable "domain_name" {
  description = "Domain name of application. Ex: 'harryseong.com'"
  type        = string
}

variable "nat_instance_ec2_configs" {
  description = "Map of input values for EC2 module."
  type        = map(any)
}
