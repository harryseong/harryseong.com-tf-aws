data "aws_api_gateway_domain_name" "api" {
  domain_name = local.api_url
}

module "route53_record_api_gateway_custom_domain_name" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "2.3.0"
  create  = true # (1) Set to "false" on first run. (2) Set to "true" after API Gateway custom domain name has been created. 

  private_zone = false
  zone_id      = var.public_hosted_zone_id
  records = [
    {
      name = local.api_prefix
      type = "A"
      alias = {
        zone_id                = data.aws_api_gateway_domain_name.api.regional_zone_id
        name                   = data.aws_api_gateway_domain_name.api.regional_domain_name
        evaluate_target_health = false
      }
    }
  ]
}
