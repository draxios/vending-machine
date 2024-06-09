resource "aws_api_gateway_rest_api" "devops_automation_api" {
  name        = "DevOpsAutomationAPI"
  description = "API Gateway for triggering Step Functions"
}

resource "aws_api_gateway_resource" "create_resource" {
  rest_api_id = aws_api_gateway_rest_api.devops_automation_api.id
  parent_id   = aws_api_gateway_rest_api.devops_automation_api.root_resource_id
  path_part   = "create"
}

resource "aws_api_gateway_method" "post_method" {
  rest_api_id   = aws_api_gateway_rest_api.devops_automation_api.id
  resource_id   = aws_api_gateway_resource.create_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "step_functions_integration" {
  rest_api_id = aws_api_gateway_rest_api.devops_automation_api.id
  resource_id = aws_api_gateway_resource.create_resource.id
  http_method = aws_api_gateway_method.post_method.http_method
  integration_http_method = "POST"
  type        = "AWS"
  uri         = "arn:aws:apigateway:${var.region}:states:action/StartExecution"

  request_templates = {
    "application/json" = <<-EOF
      {
        "input": "$util.escapeJavaScript($input.json('$'))",
        "name": "myStepFunctionExecution"
      }
    EOF
  }

  credentials = aws_iam_role.step_functions_execution_role.arn
}

resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [
    aws_api_gateway_integration.step_functions_integration
  ]
  rest_api_id = aws_api_gateway_rest_api.devops_automation_api.id
  stage_name  = "prod"
}

resource "aws_iam_role_policy" "api_gateway_invoke_policy" {
  role = aws_iam_role.step_functions_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "states:StartExecution",
        Resource = aws_sfn_state_machine.create_repo_and_workspace.arn
      }
    ]
  })
}
