module "cicd" {
  source = "./cicd"

  webapp_s3_bucket_name = module.s3_bucket_angular_test.s3_bucket_id
  webapp_s3_bucket_arn  = module.s3_bucket_angular_test.s3_bucket_arn
}
