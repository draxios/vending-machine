module "devops_automation_api" {
  source  = "tfe.csa.stoker.com/stoker-iac/mod-api-gateway-v1-rest-api/aws"
  version = ">=2.0.0,<3.0.0"

  name            = "DevOpsAutomationAPI"
  description     = "API Gateway for triggering Step Functions"
  policy          = null
  endpoint_configuration_type = "REGIONAL"

  tags = {
    Name = "DevOpsAutomationAPI"
  }
}

module "devops_automation_api_method" {
  source  = "tfe.csa.stoker.com/stoker-iac/mod-api-gateway-v1-method/aws"
  version = ">=1.0.0,<2.0.0"

  rest_api_id   = module.devops_automation_api.id
  resource_id   = module.devops_automation_api.root_resource_id
  http_method   = "POST"
  authorization = "NONE"
  integration = {
    type                = "AWS"
    integration_http_method = "POST"
    uri                 = "arn:aws:apigateway:${var.region}:states:action/StartExecution"
    credentials         = module.step_functions_execution_role.arn
    request_templates   = {
      "application/json" = <<TEMPLATE
{
  "input": "$util.escapeJavaScript($input.json('$'))",
  "name": "myStepFunctionExecution"
}
TEMPLATE
    }
  }

  tags = {
    Name = "DevOpsAutomationAPI-POST"
  }
}
