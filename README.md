# AWS Lambda Cron Terraform Module

This module will deploy a lambda function and a cron rule to run the lambda function on a schedule.

## Module Input Variables

- `filename` - (string) - **OPTIONAL** - The path to the function's deployment package within the local filesystem. If defined, The `s3_`-prefixed options cannot be used. The `source_code_hash` will be automatically added.
- `s3_bucket` - (string) - **OPTIONAL** - The name of the bucket containing your uploaded lambda deployment package
- `s3_key` - (string) - **OPTIONAL** - The s3 key for your Lambda deployment package
- `function_name` - (string) - **REQUIRED** - The name of the lambda function
- `handler` - (map) - **REQUIRED** - The function within your code that Lambda calls to begin execution.
- `runtime` - (string) - **REQUIRED** The runtime environment for the Lambda function you are uploading.
- `lambda_env` - (string) - Environment parameters passed to the lambda function
- `lambda_iam_policy_name` (string) - **REQUIRED** - The name for the Lambda functions IAM policy
- `lambda_cron_schedule` (string) - **REQUIRED** - The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes).

## Usage

```hcl
module "lambda-function" {
  source                    = "github.com/mergermarket/tf_aws_lambda"
  s3_bucket                 = "s3_bucket_name"
  s3_key                    = "s3_key_for_lambda"
  function_name             = "do_foo"
  handler                   = "do_foo_handler"
  runtime                   = "nodejs"
  lambda_env                = "${var.lambda_env}"
  lambda_iam_policy_name    = "name for lambda iam policy"
  lambda_cron_schedule      = "rate(5 minutes)"
}
```
Lambda environment variables file:
```json
{
  "lambda_env": {
    "environment_name": "ci-testing"
  }
}
```
