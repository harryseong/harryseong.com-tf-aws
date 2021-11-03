resource "aws_iam_policy" "lambda_iam_policy_ssm_params" {
  name        = "${var.project_name}-lambda-ssm-params-access-${data.aws_region.current.name}"
  description = "Lambda policy to fetch SSM Parameter store values and KMS decrypt."
  tags        = local.tags

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "kms:Decrypt"
            ],
            "Resource": "arn:aws:kms:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:key/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ssm:Describe*",
                "ssm:Get*",
                "ssm:List*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_policy" "lambda_iam_policy_dynamodb" {
  name        = "${var.project_name}-lambda-dynamodb-access-${data.aws_region.current.name}"
  description = "Lambda policy to access DynamoDB."
  tags        = local.tags

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "dynamodb:BatchGetItem",
                "dynamodb:Describe*",
                "dynamodb:List*",
                "dynamodb:GetItem",
                "dynamodb:Query",
                "dynamodb:Scan",
                "dynamodb:PartiQLSelect"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}
