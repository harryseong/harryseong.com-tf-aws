output "prod_app_vpc" {
  description = "VPC details for prod-app-vpc."
  value       = module.network.prod_app_vpc
}

output "public_hosted_zone_details" {
  value = {
    zone_id      = module.route53_public_hosted_zone.zone_id
    zone_name    = module.route53_public_hosted_zone.zone_name
    name_servers = module.route53_public_hosted_zone.name_servers
  }
}

output "cognito_user_pool_id" {
  description = "Cognito user pool ID."
  value       = module.backend.cognito_user_pool_id
}
