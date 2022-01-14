resource "aws_sns_topic" "weather_updates" {
  name              = "weather-updates-topic"
  kms_master_key_id = "alias/aws/sns"

  tags = local.tags
}

