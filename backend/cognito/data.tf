data "aws_region" "current" {}

data "aws_ssm_parameter" "google_oauth_client_id" {
  name            = aws_ssm_parameter.idp_google_oauth_client_id.name
  with_decryption = true
}
