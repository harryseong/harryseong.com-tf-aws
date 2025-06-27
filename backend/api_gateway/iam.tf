resource "aws_iam_role" "api-gateway-lambda-execution-role" {
  name        = "${var.project_name}-api-gateway-lambda-execution-role-${data.aws_region.current.region}"
  description = "API Gateway role to invoke Lambda functions."
  tags        = local.tags

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "apigateway.amazonaws.com",
          "lambda.amazonaws.com"
        ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "api-gateway-lambda-execution-policy" {
  name = "${var.project_name}-api-gateway-lambda-execution-policy-${data.aws_region.current.region}"
  role = aws_iam_role.api-gateway-lambda-execution-role.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "lambda:InvokeFunction",
      "Resource": "*"
    }
  ]
}
EOF
}
