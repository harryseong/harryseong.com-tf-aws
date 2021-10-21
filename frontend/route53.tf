module "route53_record_cloudfront" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "2.3.0"

  private_zone = false
  zone_name    = "harryseong.com"
  records = [
    {
      name = "test"
      type = "A"

      alias = {
        name                   = module.cloudfront.cloudfront_distribution_domain_name
        zone_id                = module.cloudfront.cloudfront_distribution_hosted_zone_id
        evaluate_target_health = false
      }
    }
  ]
}
