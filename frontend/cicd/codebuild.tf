resource "aws_codebuild_project" "test_codebuild_project" {
  name           = "${var.project_name}-${var.env}"
  description    = "CodeBuild project for ${var.webapp_url}."
  build_timeout  = "15"
  queued_timeout = "30"
  service_role   = aws_iam_role.codebuild_role.arn
  tags           = local.tags

  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type  = "LOCAL"
    modes = ["LOCAL_DOCKER_LAYER_CACHE", "LOCAL_SOURCE_CACHE"]
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = file("./frontend/cicd/buildspec.yaml")
  }
}
