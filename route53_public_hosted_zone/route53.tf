module "route53_public_hosted_zone" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "2.3.0"
  create  = true

  tags = local.tags
  zones = {
    (var.domain_name) = { name = var.domain_name }
  }
}

# TODO: Remove the following manual Route53 records:
data "aws_cloudfront_distribution" "harryseong" {
  id = "E39WW4F0GP58UC"
}

data "aws_api_gateway_domain_name" "harryseong" {
  domain_name = "api.harryseong.com"
}

module "route53_record_cloudfront" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "2.3.0"
  create  = true # (1) Set to "false" on first run. (2) Set to "true" after CloudFront distribution has been created. 

  private_zone = false
  zone_id      = module.route53_public_hosted_zone.route53_zone_zone_id[var.domain_name]
  records = [
    {
      name = "www"
      type = "A"
      alias = {
        zone_id                = data.aws_cloudfront_distribution.harryseong.hosted_zone_id
        name                   = data.aws_cloudfront_distribution.harryseong.domain_name
        evaluate_target_health = false
      }
    },
    {
      name = ""
      type = "A"
      alias = {
        zone_id                = data.aws_cloudfront_distribution.harryseong.hosted_zone_id
        name                   = data.aws_cloudfront_distribution.harryseong.domain_name
        evaluate_target_health = false
      }
    },
    {
      name = "api"
      type = "A"
      alias = {
        zone_id                = data.aws_api_gateway_domain_name.harryseong.cloudfront_zone_id
        name                   = data.aws_api_gateway_domain_name.harryseong.cloudfront_domain_name
        evaluate_target_health = false
      }
    }
  ]
}
