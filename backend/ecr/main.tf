resource "aws_ecr_repository" "repo" {
  name                 = var.domain_name
  image_tag_mutability = "MUTABLE"
  encryption_configuration {
    encryption_type = "KMS"
  }

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = local.tags
}
