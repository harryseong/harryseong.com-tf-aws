module "cicd" {
  source = "./cicd"

  env                     = var.env
  project_name            = var.project_name
  domain_name             = var.domain_name
  webapp_url              = local.webapp_url
  webapp_s3_bucket_name   = module.s3_bucket_angular_test.s3_bucket_id
  webapp_s3_bucket_arn    = module.s3_bucket_angular_test.s3_bucket_arn
  codestarconnections_arn = var.codestarconnections_arn
}
