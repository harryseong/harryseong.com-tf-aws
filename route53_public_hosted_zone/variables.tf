variable "env" {
  description = "Environment. Values: ['dev', 'test', 'prod', 'shared']"
  type        = string
}

variable "domain_name" {
  description = "Domain name of application. Ex: 'harryseong.com'"
  type        = string
}
