module "api_gateway" {
  source                           = "terraform-aws-modules/apigateway-v2/aws"
  version                          = "1.4.0"
  create                           = true
  create_api_domain_name           = true  # to control creation of API Gateway Domain Name
  create_default_stage             = false # to control creation of "$default" stage
  create_default_stage_api_mapping = false # to control creation of "$default" stage and API mapping

  name                         = local.api_url
  description                  = "API for ${var.domain_name} web application."
  protocol_type                = "HTTP"
  disable_execute_api_endpoint = false

  domain_name                 = local.api_url
  domain_name_certificate_arn = module.acm_certificate.acm_certificate_arn
  domain_name_tags            = local.tags

  cors_configuration = {
    allow_headers = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent"]
    allow_methods = ["*"]
    allow_origins = ["*"]
  }

  integrations = {
    "GET /v1/places" = {
      lambda_arn             = var.lambda_functions["get-places"]
      payload_format_version = "2.0"
      timeout_milliseconds   = 12000
      credentials_arn        = aws_iam_role.api-gateway-lambda-execution-role.arn
    }
    "GET /v1/bucket-list" = {
      lambda_arn             = var.lambda_functions["get-bucket-list-items"]
      payload_format_version = "2.0"
      timeout_milliseconds   = 12000
      credentials_arn        = aws_iam_role.api-gateway-lambda-execution-role.arn
    }
    "GET /v1/weather" = {
      lambda_arn             = var.lambda_functions["get-weather"]
      payload_format_version = "2.0"
      timeout_milliseconds   = 12000
      credentials_arn        = aws_iam_role.api-gateway-lambda-execution-role.arn
    }
    "GET /v1/music/spotify/currently-playing" = {
      lambda_arn             = var.lambda_functions["get-spotify-currently-playing"]
      payload_format_version = "2.0"
      timeout_milliseconds   = 12000
      credentials_arn        = aws_iam_role.api-gateway-lambda-execution-role.arn
    }
  }

  tags = local.tags
}

resource "aws_apigatewayv2_stage" "api_gateway_stage" {
  for_each = toset(local.api_gateway_stages)

  api_id          = module.api_gateway.apigatewayv2_api_id
  name            = each.key
  auto_deploy     = each.key == "prod" ? false : true
  stage_variables = { "lambdaAlias" = each.key }
  tags            = local.tags
}

resource "aws_apigatewayv2_authorizer" "jwt_authorizer" {
  api_id           = module.api_gateway.apigatewayv2_api_id
  authorizer_type  = "JWT"
  identity_sources = ["$request.header.Authorization"]
  name             = "jwt-authorizer"

  jwt_configuration {
    audience = ["21msja2gfpqpgbjtgfcdbsvjue"]
    issuer   = "https://cognito-idp.us-east-1.amazonaws.com/us-east-1_hnYwzLczn"
  }
}
