resource "aws_secretsmanager_secret" "azure_devops_pat" {
  name = "AzureDevOpsPAT"
}

resource "aws_secretsmanager_secret_version" "azure_devops_pat_version" {
  secret_id     = aws_secretsmanager_secret.azure_devops_pat.id
  secret_string = jsonencode({
    pat = "your_azure_devops_pat_here"
  })
}

resource "aws_secretsmanager_secret" "terraform_enterprise_token" {
  name = "TerraformEnterpriseToken"
}

resource "aws_secretsmanager_secret_version" "terraform_enterprise_token_version" {
  secret_id     = aws_secretsmanager_secret.terraform_enterprise_token.id
  secret_string = jsonencode({
    token = "your_terraform_enterprise_token_here"
  })
}
