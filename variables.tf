variable "filename" {
  description = "The path to the function's deployment package within the local filesystem. If defined, The s3_-prefixed options cannot be used. The source_code_hash will be automatically added."
  default     = ""
}

variable "s3_bucket" {
  description = "The name of the bucket containing your uploaded lambda deployment package."
  default     = ""
}

variable "s3_key" {
  description = "The s3 key for your Lambda deployment package."
  default     = ""
}

variable "function_name" {
  description = "The name of the lambda function."
}

variable "handler" {
  description = "The function within your code that Lambda calls to begin execution."
}

variable "runtime" {
  description = "The runtime environment for the Lambda function you are uploading."
}

variable "lambda_env" {
  description = "Environment parameters passed to the lambda function."
  type        = "map"
  default     = {}
}

variable "lambda_iam_policy_name" {
  description = "The name for the Lambda functions IAM policy."
}

variable "lambda_cron_schedule" {
  description = "The sceduling expression for how often the lambda function runs."
}
