module "cloudfront" {
  source = "terraform-aws-modules/cloudfront/aws"

  aliases = [local.webapp_url]

  comment             = "CloudFront for ${local.webapp_url} Angular webapp."
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_100" # "PriceClass_All" for production
  retain_on_delete    = false
  wait_for_deployment = false
  tags                = local.tags

  create_origin_access_identity = true
  origin_access_identities = {
    s3_bucket_oai = "CloudFront OAI for Angular webapp S3 bucket."
  }

  origin = {
    "s3-${local.webapp_url}" = {
      domain_name = module.s3_bucket_angular_test.s3_bucket_website_endpoint
      custom_origin_config = {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "https-only"
        origin_ssl_protocols   = ["TLSv1.2"]
      }
    }
  }

  default_cache_behavior = {
    target_origin_id       = "s3-${local.webapp_url}"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    # cache_policy_id = "caching-disabled"
  }

  viewer_certificate = {
    acm_certificate_arn      = module.acm_certificate.acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}
