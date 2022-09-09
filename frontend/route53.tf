module "route53_record_cloudfront" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "2.3.0"
  create  = true # (1) Set to "false" on first run. (2) Set to "true" after CloudFront distribution has been created. 

  private_zone = false
  zone_id      = var.public_hosted_zone_id
  records = concat([
    {
      name = local.webapp_prefix
      type = "A"
      alias = {
        name                   = module.cloudfront.cloudfront_distribution_domain_name
        zone_id                = module.cloudfront.cloudfront_distribution_hosted_zone_id
        evaluate_target_health = false
      }
    }
    ],
    # If prod, add Route53 CNAME record for "www" to domain.
    var.env == "prod" ? [{
      name = "www"
      type = "A"
      alias = {
        name                   = local.webapp_url
        zone_id                = var.public_hosted_zone_id
        evaluate_target_health = false
      }
    }] : []
  )
}

module "route53_record_azure" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "2.3.0"
  create  = var.env == "prod"

  private_zone = false
  zone_id      = var.public_hosted_zone_id
  records = [
    {
      name    = "azure"
      type    = "CNAME"
      records = ["harryseong.z13.web.core.windows.net"]
      ttl     = 300
    }
  ]
}
