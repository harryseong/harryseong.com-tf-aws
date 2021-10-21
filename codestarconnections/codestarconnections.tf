# CodeStarConnections require manual approval in AWS management console: [AWS Developer Tools > Settings > Connections]
resource "aws_codestarconnections_connection" "github" {
  name          = "harryseong"
  provider_type = "GitHub"
  tags          = local.tags
}
