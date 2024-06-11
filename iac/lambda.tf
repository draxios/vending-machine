module "create_azure_devops_repo_lambda" {
  source  = "tfe.csa.stoker.com/stoker-iac/mod-lambda/aws"
  version = ">=7.0.0,<8.0.0"

  environment   = "dev"
  function_name = "CreateAzureDevOpsRepo"
  description   = "Lambda function to create Azure DevOps repository"
  handler       = "create_azure_devops_repo.lambda_handler"
  runtime       = "python3.8"
  filename      = "lambda_functions/create_azure_devops_repo.zip"
  role          = module.lambda_execution_role.arn

  tags = {
    Name = "CreateAzureDevOpsRepo"
  }
}

module "create_terraform_workspace_lambda" {
  source  = "tfe.csa.stoker.com/stoker-iac/mod-lambda/aws"
  version = ">=7.0.0,<8.0.0"

  environment   = "dev"
  function_name = "CreateTerraformWorkspace"
  description   = "Lambda function to create Terraform workspace"
  handler       = "create_terraform_workspace.lambda_handler"
  runtime       = "python3.8"
  filename      = "lambda_functions/create_terraform_workspace.zip"
  role          = module.lambda_execution_role.arn

  tags = {
    Name = "CreateTerraformWorkspace"
  }
}
