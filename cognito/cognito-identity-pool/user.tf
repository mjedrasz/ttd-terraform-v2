
module "user_identity_pool" {
  source                      = "./identity-pool"
  identity_pool_name          = "${var.aws_env} user identity pool"
  identity_provider_client_id = data.terraform_remote_state.cognito_user_pool_client.outputs.mobile_client_id
  identity_provider_name      = "cognito-idp.${var.aws_region}.amazonaws.com/${data.terraform_remote_state.cognito_user_pool.outputs.cognito_user_pool_id}"
}

resource "aws_iam_role" "user_authenticated" {
  name = "${var.aws_env}-cognito-user-authenticated"

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
          "cognito-identity.amazonaws.com:aud": "${module.user_identity_pool.identity_pool_id}"
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

resource "aws_iam_role_policy" "user_authenticated" {
  name = "${var.aws_env}-user-authenticated"
  role = aws_iam_role.user_authenticated.id

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
        "Action": [
            "mobiletargeting:UpdateEndpoint",
            "mobiletargeting:PutEvents"
        ],
        "Resource": [
            "arn:aws:mobiletargeting:${var.aws_region}:${data.aws_caller_identity.current.account_id}:apps/${data.terraform_remote_state.pinpoint.outputs.application_id}*"
        ]
    }
  ]
}
EOF
}

resource "aws_iam_role" "user_unauthenticated" {
  name = "${var.aws_env}-cognito-user-unauthenticated"

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
          "cognito-identity.amazonaws.com:aud": "${module.user_identity_pool.identity_pool_id}"
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

resource "aws_iam_role_policy" "user_unauthenticated" {
  name = "${var.aws_env}-user-unauthenticated"
  role = aws_iam_role.user_unauthenticated.id

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
        "Action": [
            "mobiletargeting:UpdateEndpoint",
            "mobiletargeting:PutEvents"
        ],
        "Resource": [
            "arn:aws:mobiletargeting:${var.aws_region}:${data.aws_caller_identity.current.account_id}:apps/${data.terraform_remote_state.pinpoint.outputs.application_id}*"
        ]
    }
  ]
}
EOF
}

resource "aws_cognito_identity_pool_roles_attachment" "user" {
  identity_pool_id = module.user_identity_pool.identity_pool_id

  roles = {
    authenticated = aws_iam_role.user_authenticated.arn
    unauthenticated = aws_iam_role.user_unauthenticated.arn
  }
}

data "aws_caller_identity" "current" {}

resource "aws_ssm_parameter" "user_identity_pool_id" {
  name  = "/${var.aws_env}/cognito/user-identity-pool/id"
  type  = "String"
  value = module.user_identity_pool.identity_pool_id
}