module "cloudfront" {
  source = "terraform-aws-modules/cloudfront/aws"

  aliases = ["test.harryseong.com"]

  comment             = "CloudFront for test.harryseong.com Angular webapp."
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
    "s3-test.harryseong.com" = {
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
    target_origin_id       = "s3-test.harryseong.com"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    # cache_policy_id = "caching-disabled"
  }

  viewer_certificate = {
    acm_certificate_arn      = "arn:aws:acm:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:certificate/1a08456d-4661-4cc2-96df-2d14d023af14"
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}
