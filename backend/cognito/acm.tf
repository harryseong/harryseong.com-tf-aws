module "acm_certificate" {
  source             = "terraform-aws-modules/acm/aws"
  version            = "3.2.0"
  create_certificate = true

  domain_name               = local.auth_url
  subject_alternative_names = []

  validate_certificate               = true
  validation_allow_overwrite_records = true
  validation_method                  = "DNS"
  wait_for_validation                = true
  zone_id                            = var.public_hosted_zone_id

  tags = local.tags
}
