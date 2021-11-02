# module "route53_record_api_gateway_custom_domain" {
#   source  = "terraform-aws-modules/route53/aws//modules/records"
#   version = "2.3.0"
#   create  = true # (1) Set to "false" on first run. (2) Set to "true" after API Gateway custom domain has been created. 

#   private_zone = false
#   zone_id      = var.public_hosted_zone_id
#   records = [
#     {
#       name = "api"
#       type = "A"
#       alias = {
#         zone_id                = module.api_gateway.apigatewayv2_domain_name_hosted_zone_id
#         name                   = module.api_gateway.apigatewayv2_domain_name_id
#         evaluate_target_health = false
#       }
#     }
#   ]
# }
# TODO: Remove the following manual Route53 records:
# data "aws_api_gateway_domain_name" "harryseong" {
#   domain_name = "api.harryseong.com"
# }

# module "route53_record_cloudfront" {
#   source  = "terraform-aws-modules/route53/aws//modules/records"
#   version = "2.3.0"
#   create  = true # (1) Set to "false" on first run. (2) Set to "true" after CloudFront distribution has been created. 

#   private_zone = false
#   zone_id      = var.public_hosted_zone_id
#   records = [
#     {
#       name = "api"
#       type = "A"
#       alias = {
#         zone_id                = data.aws_api_gateway_domain_name.harryseong.regional_zone_id
#         name                   = data.aws_api_gateway_domain_name.harryseong.regional_domain_name
#         evaluate_target_health = false
#       }
#     }
#   ]
# }
