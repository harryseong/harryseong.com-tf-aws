variable "env" {
  description = "Environment. Values: ['api', 'dev', 'test', 'prod']"
  type        = string
}

variable "domain_name" {
  description = "Domain name of application. Ex: 'harryseong.com'"
  type        = string
}
