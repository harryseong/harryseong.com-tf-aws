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

variable "public_hosted_zone_id" {
  description = "Route53 public hosted zone ID."
  type        = string
}

variable "lambda_functions" {
  description = "Map of lambda function names and ARNs."
  type        = map(string)
}

variable "cognito_user_pool_client_id" {
  description = "Cognito user pool client ID."
  type        = string
}

variable "cognito_user_pool_endpoint" {
  description = "Cognito user pool endpoint."
  type        = string
}
