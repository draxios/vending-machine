module "create_repo_and_workspace_state_machine" {
  source  = "tfe.csa.stoker.com/stoker-iac/mod-step-functions/aws"
  version = ">=1.0.0,<2.0.0"

  state_machine_name = "CreateRepoAndWorkspace"
  role_arn           = module.step_functions_execution_role.arn
  definition = jsonencode({
    Comment = "Create Azure DevOps Repo and Terraform Enterprise Workspace",
    StartAt = "CreateAzureDevOpsRepo",
    States = {
      CreateAzureDevOpsRepo = {
        Type       = "Task",
        Resource   = module.create_azure_devops_repo_lambda.lambda_arn,
        Next       = "CreateTerraformWorkspace",
        Parameters = {
          "project_name.$"      = "$.project_name",
          "repository_name.$"   = "$.repository_name"
        }
      },
      CreateTerraformWorkspace = {
        Type       = "Task",
        Resource   = module.create_terraform_workspace_lambda.lambda_arn,
        End        = true,
        Parameters = {
          "workspace_name.$"    = "$.workspace_name"
        }
      }
    }
  })
}
