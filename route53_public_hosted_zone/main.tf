module "route53_public_hosted_zone" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "2.3.0"
  create  = true

  tags = local.tags
  zones = {
    (var.domain_name) = { name = var.domain_name }
  }
}
