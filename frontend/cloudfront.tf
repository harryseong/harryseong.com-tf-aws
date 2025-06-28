module "cloudfront" {
  source              = "terraform-aws-modules/cloudfront/aws"
  version             = "2.9.3"
  create_distribution = true

  comment             = "CloudFront for ${local.webapp_url} webapp."
  aliases             = var.env == "prod" ? [local.webapp_url, format("%s.%s", "www", local.webapp_url)] : [local.webapp_url]
  enabled             = true
  http_version        = "http2and3"
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

    cache_policy_id            = "658327ea-f89d-4fab-a63d-7e88639e58f6" # CachingOptimized
    origin_request_policy_id   = "88a5eaf4-2fd4-4709-b370-b4c650ea3fcf" # CORS-S3Origin
    response_headers_policy_id = "eaab4381-ed33-4a86-88ca-d9558dc6cd63" # CORS-with-preflight-and-SecurityHeadersPolicy

    use_forwarded_values = false
  }

  viewer_certificate = {
    acm_certificate_arn      = module.acm_certificate.acm_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}
