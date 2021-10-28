resource "aws_iam_role" "cognito_authenticated" {
  name        = "cognito-authenticated-role-${data.aws_region.current.name}"
  description = "Cognito identity pool authenticated role for access to select AWS resources."
  tags        = local.tags

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "cognito-identity.amazonaws.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "cognito-identity.amazonaws.com:aud": "${aws_cognito_identity_pool.main_idp.id}"
        },
        "ForAnyValue:StringLike": {
          "cognito-identity.amazonaws.com:amr": "authenticated"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "cognito_authenticated" {
  name = "cognito-authenticated-policy-${data.aws_region.current.name}"
  role = aws_iam_role.cognito_authenticated.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "mobileanalytics:PutEvents",
        "cognito-sync:*",
        "cognito-identity:*"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}

resource "aws_cognito_identity_pool_roles_attachment" "main_idp" {
  identity_pool_id = aws_cognito_identity_pool.main_idp.id

  role_mapping {
    identity_provider         = "accounts.google.com"
    ambiguous_role_resolution = "AuthenticatedRole"
    type                      = "Rules"

    mapping_rule {
      claim      = "isAdmin"
      match_type = "Equals"
      value      = "yes"
      role_arn   = aws_iam_role.cognito_authenticated.arn
    }
  }

  roles = {
    "authenticated" = aws_iam_role.cognito_authenticated.arn
  }
}
