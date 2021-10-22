module "cloudfront" {
  source              = "terraform-aws-modules/cloudfront/aws"
  version             = "2.8.0"
  create_distribution = true

  comment             = "CloudFront for ${local.webapp_url} webapp."
  aliases             = [local.webapp_url]
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = var.env == "prod" ? "PriceClass_All" : "PriceClass_100"
  retain_on_delete    = false
  wait_for_deployment = false
  tags                = local.tags

  origin = {
    "s3-${local.webapp_url}" = {
      domain_name = module.webapp_s3_bucket.s3_bucket_website_endpoint
      custom_origin_config = {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "http-only"
        origin_ssl_protocols   = ["TLSv1.2"]
      }
    }
  }

  default_cache_behavior = {
    target_origin_id       = "s3-${local.webapp_url}"
    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    allowed_methods = ["GET", "HEAD"]
  }

  viewer_certificate = {
    acm_certificate_arn      = module.acm_certificate.acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}
