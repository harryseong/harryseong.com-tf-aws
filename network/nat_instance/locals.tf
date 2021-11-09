locals {
  tags = {
    Terraform   = "true"
    Environment = var.env
  }

  ec2_ssm_iam_policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
