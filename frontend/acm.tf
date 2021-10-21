module "acm_certificate" {
  source  = "terraform-aws-modules/acm/aws"
  version = "3.2.0"

  create_certificate        = true
  domain_name               = local.webapp_url
  subject_alternative_names = var.env == "prod" ? [var.domain_name] : []

  validate_certificate               = true
  validation_allow_overwrite_records = true
  validation_method                  = "DNS"
  wait_for_validation                = true
  zone_id                            = "Z0149004142QD55ZYA8IM"

  tags = local.tags
}
