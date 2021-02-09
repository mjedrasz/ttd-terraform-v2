
module "org_identity_pool" {
  source                      = "./identity-pool"
  identity_pool_name          = "${var.aws_env} org identity pool"
  identity_provider_client_id = data.terraform_remote_state.cognito_user_pool_client.outputs.web_client_id
  identity_provider_name      = "cognito-idp.${var.aws_region}.amazonaws.com/${data.terraform_remote_state.cognito_user_pool.outputs.cognito_org_pool_id}"
}

resource "aws_iam_role" "org_authenticated" {
  name = "${var.aws_env}-cognito-org-authenticated"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "cognito-identity.amazonaws.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "cognito-identity.amazonaws.com:aud": "${module.org_identity_pool.identity_pool_id}"
        },
        "ForAnyValue:StringLike": {
          "cognito-identity.amazonaws.com:amr": "authenticated"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "org_authenticated" {
  name = "${var.aws_env}-org-authenticated"
  role = aws_iam_role.org_authenticated.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "cognito-identity:*"
      ],
      "Resource": [
        "*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": "s3:PutObject",
      "Resource": [
        "${data.terraform_remote_state.s3_assets.outputs.arn}/public/$${cognito-identity.amazonaws.com:sub}/images",
        "${data.terraform_remote_state.s3_assets.outputs.arn}/public/$${cognito-identity.amazonaws.com:sub}/images/*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role" "org_unauthenticated" {
  name = "${var.aws_env}-cognito-org-unauthenticated"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "cognito-identity.amazonaws.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "cognito-identity.amazonaws.com:aud": "${module.org_identity_pool.identity_pool_id}"
        },
        "ForAnyValue:StringLike": {
          "cognito-identity.amazonaws.com:amr": "unauthenticated"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "org_unauthenticated" {
  name = "${var.aws_env}-org-unauthenticated"
  role = aws_iam_role.org_unauthenticated.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "cognito-identity:*"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
EOF
}

resource "aws_cognito_identity_pool_roles_attachment" "org" {
  identity_pool_id = module.org_identity_pool.identity_pool_id

  roles = {
    authenticated = aws_iam_role.org_authenticated.arn
    unauthenticated = aws_iam_role.org_unauthenticated.arn
  }
}

resource "aws_ssm_parameter" "org_identity_pool_id" {
  name  = "/${var.aws_env}/cognito/identity-pools/org/id"
  type  = "String"
  value = module.org_identity_pool.identity_pool_id
}
