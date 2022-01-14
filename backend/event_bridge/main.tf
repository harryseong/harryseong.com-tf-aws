data "aws_lambda_function" "daily_weather_updates" {
  function_name = "daily-weather-updates"
}
resource "aws_cloudwatch_event_rule" "daily_weather_updates" {
  name        = "send-daily-weather-updates"
  description = "Send daily weather updates to Harry at 7:00 AM CST."

  schedule_expression = "cron(0 13 * * ? *)" // Everyday at 1:00 PM UTC / 7:00 AM CST.

  tags = local.tags
}

resource "aws_cloudwatch_event_target" "daily_weather_updates" {
  rule = aws_cloudwatch_event_rule.daily_weather_updates.name
  arn  = data.aws_lambda_function.daily_weather_updates.arn
}
