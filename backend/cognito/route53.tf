module "route53_record_user_pool_domain" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "2.3.0"
  create  = true # (1) Set to "false" on first run. (2) Set to "true" after Cognito User Pool domain has been created (takes ~7-10 mins). 

  private_zone = false
  zone_id      = var.public_hosted_zone_id
  records = [
    {
      name = local.auth_prefix
      type = "A"
      alias = {
        name                   = aws_cognito_user_pool_domain.main.cloudfront_distribution_arn
        zone_id                = "Z2FDTNDATAQYW2" # Zone ID is fixed for Cognito user pool domain CDN.
        evaluate_target_health = false
      }
    }
  ]
}
