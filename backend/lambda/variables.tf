variable "env" {
  description = "Environment. Values: ['api', 'dev', 'test', 'prod']"
  type        = string
}

variable "project_name" {
  description = "Project name. Ex: 'harryseong'"
  type        = string
}

variable "domain_name" {
  description = "Domain name of application. Ex: 'harryseong.com'"
  type        = string
}

variable "vpc_default_security_group_id" {
  description = "VPC's default security group ID."
  type        = string
}

variable "vpc_private_subnet_ids" {
  description = "VPC's private subnet IDs."
  type        = list(string)
}
