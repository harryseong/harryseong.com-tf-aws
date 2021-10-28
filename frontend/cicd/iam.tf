######################################
# CodePipeline IAM Role and Policies #
######################################
resource "aws_iam_role" "codepipeline_role" {
  name        = "codepipeline-role-${var.project_name}-${var.env}-${data.aws_region.current.name}"
  description = "CodePipeline role to access S3, CodeBuild, CodeStarConnections."
  tags        = local.tags

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "codepipeline-policy-${var.project_name}-${var.env}-${data.aws_region.current.name}"
  role = aws_iam_role.codepipeline_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect":"Allow",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:GetBucketVersioning",
        "s3:PutObjectAcl",
        "s3:PutObject"
      ],
      "Resource": [
        "${module.codepipeline_artifacts_s3_bucket.s3_bucket_arn}",
        "${module.codepipeline_artifacts_s3_bucket.s3_bucket_arn}/*",
        "${var.webapp_s3_bucket_arn}",
        "${var.webapp_s3_bucket_arn}/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "codestar-connections:UseConnection"
      ],
      "Resource": "${var.codestarconnections_arn}"
    },
    {
      "Effect": "Allow",
      "Action": [
        "codebuild:BatchGetBuilds",
        "codebuild:StartBuild"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}


###################################
# CodeBuild IAM Role and Policies #
###################################
resource "aws_iam_role" "codebuild_role" {
  name        = "codebuild-role-${var.project_name}-${var.env}-${data.aws_region.current.name}"
  description = "CodeBuild role to access S3, CloudWatch Logs, SSM Param Store, KMS."
  tags        = local.tags

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codebuild_policy" {
  name = "codebuild-policy-${var.project_name}-${var.env}-${data.aws_region.current.name}"
  role = aws_iam_role.codebuild_role.name

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "${module.codepipeline_artifacts_s3_bucket.s3_bucket_arn}",
        "${module.codepipeline_artifacts_s3_bucket.s3_bucket_arn}/*"
      ]
    },
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
POLICY
}
