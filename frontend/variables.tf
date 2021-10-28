variable "env" {
  description = "Environment. Values: ['dev', 'test', 'prod']"
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

variable "codestarconnections_arn" {
  description = "CodeStarConnections connection ARN."
  type        = string
}

variable "cognito_idp_id" {
  description = "Cognito identity pool ID."
  type        = string
}
