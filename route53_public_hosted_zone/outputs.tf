output "zone_id" {
  value = module.route53_public_hosted_zone.route53_zone_zone_id[var.domain_name]
}

output "zone_name" {
  value = module.route53_public_hosted_zone.route53_zone_name[var.domain_name]
}

output "name_servers" {
  value = module.route53_public_hosted_zone.route53_zone_name_servers[var.domain_name]
}
