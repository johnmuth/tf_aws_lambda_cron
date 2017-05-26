resource "aws_lambda_function" "lambda_function" {
  filename         = "${var.filename}"
  source_code_hash = "${var.filename == "" ? "" : base64sha256(file(var.filename))}"
  s3_bucket        = "${var.s3_bucket}"
  s3_key           = "${var.s3_key}"
  function_name    = "${var.function_name}"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "${var.handler}"
  runtime          = "${var.runtime}"

  environment {
    variables = "${var.lambda_env}"
  }
}

resource "aws_cloudwatch_event_rule" "cron_schedule" {
  name                = "${var.function_name}-cron_schedule"
  description         = "This event will run according to a schedule for lambda ${var.function_name}"
  schedule_expression = "${var.lambda_cron_schedule}"
}

resource "aws_cloudwatch_event_target" "event_target" {
  rule      = "${aws_cloudwatch_event_rule.cron_schedule.name}"
  arn       = "${aws_lambda_function.lambda_function.arn}"
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda_function.function_name}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.cron_schedule.arn}"
}

output "lambda_arn" {
  value = "${aws_lambda_function.lambda_function.arn}"
}
