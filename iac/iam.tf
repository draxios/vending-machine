data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}

module "lambda_execution_role" {
  source  = "tfe.csa.stoker.com/stoker-iac/mod-iam-role/aws"
  version = ">=2.0.0,<3.0.0"

  role_name                             = "lambda_execution_role"
  role_description                      = "Role for Lambda execution"
  role_assume_role_policy_document_json = data.aws_iam_policy_document.lambda_assume_role_policy.json
  role_inline_policies = {
    "lambda_policy" = data.aws_iam_policy_document.lambda_policy_document.json
  }
  tags = {
    Name = "lambda_execution_role"
  }
}

data "aws_iam_policy_document" "step_functions_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["states.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "step_functions_policy_document" {
  statement {
    effect = "Allow"
    actions = ["lambda:InvokeFunction"]
    resources = ["*"]
  }
}

module "step_functions_execution_role" {
  source  = "tfe.csa.stoker.com/stoker-iac/mod-iam-role/aws"
  version = ">=2.0.0,<3.0.0"

  role_name                             = "step_functions_execution_role"
  role_description                      = "Role for Step Functions execution"
  role_assume_role_policy_document_json = data.aws_iam_policy_document.step_functions_assume_role_policy.json
  role_inline_policies = {
    "step_functions_policy" = data.aws_iam_policy_document.step_functions_policy_document.json
  }
  tags = {
    Name = "step_functions_execution_role"
  }
}
