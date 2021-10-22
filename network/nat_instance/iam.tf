resource "aws_iam_instance_profile" "nat_instance_profile" {
  name = "nat-instance-profile-${data.aws_region.current.name}"
  role = aws_iam_role.nat_instance_iam_role.name
  tags = local.tags
}

resource "aws_iam_role" "nat_instance_iam_role" {
  name = "nat-instance-profile-${data.aws_region.current.name}"
  path = "/"
  tags = local.tags

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow"
        }
    ]
}
EOF
}

resource "aws_iam_policy" "nat_instance_iam_policy_ec2" {
  name        = "nat-instance-ec2-action-${data.aws_region.current.name}"
  description = "Policy to allow NAT instances to perform required EC2 actions."
  tags        = local.tags

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ec2:CreateTags",
                "ec2:ModifyInstanceAttribute"
            ],
            "Resource": "arn:aws:ec2:*:${data.aws_caller_identity.current.account_id}:instance/*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "ec2:DescribeSpotInstanceRequests",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "nat_instance_iam_policy_ec2_attach" {
  role       = aws_iam_role.nat_instance_iam_role.name
  policy_arn = aws_iam_policy.nat_instance_iam_policy_ec2.arn
}
