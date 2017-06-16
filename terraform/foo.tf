resource "aws_api_gateway_resource" "foo" {
  rest_api_id = "${module.api_gateway_base.rest_api_id}"
  parent_id   = "${module.api_gateway_base.root_resource_id}"
  path_part   = "foo"
}

module "api_gateway_foo_cors" {
  source = "git::https://balihoo-terraform:P64uHcX$aEVz@github.com/balihoo/terraform-modules//balihoo-serverless-api-gateway-cors"

  resource_name = "${module.api_gateway_foo_get.method}"
  resource_id   = "${aws_api_gateway_resource.foo.id}"
  rest_api_id   = "${module.api_gateway_base.rest_api_id}"
}

module "api_gateway_foo_get" {
  source = "git::https://balihoo-terraform:P64uHcX$aEVz@github.com/balihoo/terraform-modules//balihoo-serverless-api-gateway"

  rest_api_id = "${module.api_gateway_base.rest_api_id}"
  resource_id = "${aws_api_gateway_resource.foo.id}"
  lambda_uri  = "${module.api_lambda_foo_get.uri}"
}

module "api_lambda_foo_get" {
  source = "git::https://balihoo-terraform:P64uHcX$aEVz@github.com/balihoo/terraform-modules//balihoo-serverless-api-lambda"

  # Inherit from variables.tf
  region      = "${var.region}"
  account     = "${var.account}"
  environment = "${var.environment}"

  # Inherit from main.tf
  rest_api_id = "${module.api_gateway_base.rest_api_id}"

  lambda_zip     = "foo_get.zip"
  lambda_name    = "foo_get_${var.environment}"
  lambda_handler = "foo_get.lambda_handler"
}
