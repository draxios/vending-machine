resource "aws_lambda_function" "create_azure_devops_repo" {
  filename         = "lambda_functions/create_azure_devops_repo.zip"
  function_name    = "CreateAzureDevOpsRepo"
  role             = aws_iam_role.lambda_execution_role.arn
  handler          = "create_azure_devops_repo.lambda_handler"
  runtime          = "python3.8"
  source_code_hash = filebase64sha256("lambda_functions/create_azure_devops_repo.zip")
  
  environment {
    variables = {
      SECRETS_MANAGER_REGION = "us-east-1"
    }
  }
}

resource "aws_lambda_function" "create_terraform_workspace" {
  filename         = "lambda_functions/create_terraform_workspace.zip"
  function_name    = "CreateTerraformWorkspace"
  role             = aws_iam_role.lambda_execution_role.arn
  handler          = "create_terraform_workspace.lambda_handler"
  runtime          = "python3.8"
  source_code_hash = filebase64sha256("lambda_functions/create_terraform_workspace.zip")
  
  environment {
    variables = {
      SECRETS_MANAGER_REGION = "us-east-1"
    }
  }
}
