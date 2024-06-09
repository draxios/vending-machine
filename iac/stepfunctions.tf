resource "aws_sfn_state_machine" "create_repo_and_workspace" {
  name     = "CreateRepoAndWorkspace"
  role_arn = aws_iam_role.step_functions_execution_role.arn

  definition = jsonencode({
    Comment = "Create Azure DevOps Repo and Terraform Enterprise Workspace",
    StartAt = "CreateAzureDevOpsRepo",
    States = {
      CreateAzureDevOpsRepo = {
        Type       = "Task",
        Resource   = aws_lambda_function.create_azure_devops_repo.arn,
        Next       = "CreateTerraformWorkspace",
        Parameters = {
          "project_name.$"      = "$.project_name",
          "repository_name.$"   = "$.repository_name"
        }
      },
      CreateTerraformWorkspace = {
        Type       = "Task",
        Resource   = aws_lambda_function.create_terraform_workspace.arn,
        End        = true,
        Parameters = {
          "workspace_name.$"    = "$.workspace_name"
        }
      }
    }
  })
}
