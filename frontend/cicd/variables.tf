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

variable "webapp_url" {
  description = "Webapp URL. Ex: 'www.harryseong.com', 'test.harryseong.com'"
  type        = string
}

variable "webapp_s3_bucket_name" {
  description = "S3 bucket name for hosting Angular webapp."
  type        = string
}

variable "webapp_s3_bucket_arn" {
  description = "S3 bucket ARN for hosting Angular webapp."
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
