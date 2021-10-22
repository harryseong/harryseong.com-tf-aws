variable "env_list" {
  description = "List of environments. Ex: ['dev', 'test', 'prod']"
  type        = list(string)
}

variable "project_name" {
  description = "Project name. Ex: 'harryseong'"
  type        = string
}

variable "domain_name" {
  description = "Domain name of application. Ex: 'harryseong.com'"
  type        = string
}
