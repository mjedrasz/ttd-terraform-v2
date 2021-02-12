resource "aws_iam_role" "authenticated" {
  name = "${var.aws_env}-cognito-${var.name}-authenticated"
  assume_role_policy = var.authenticated_assume_role_policy
}

resource "aws_iam_role_policy" "authenticated" {
  name = "${var.aws_env}-${var.name}-authenticated"
  role = aws_iam_role.authenticated.id

  policy = var.authenticated_policy
}

resource "aws_iam_role" "unauthenticated" {
  name = "${var.aws_env}-cognito-${var.name}-unauthenticated"

  assume_role_policy = var.unauthenticated_assume_role_policy
}

resource "aws_iam_role_policy" "unauthenticated" {
  name = "${var.aws_env}-${var.name}-unauthenticated"
  role = aws_iam_role.unauthenticated.id

  policy = var.unauthenticated_policy
}

resource "aws_cognito_identity_pool_roles_attachment" "roles_attachment" {
  identity_pool_id = var.identity_pool_id

  roles = {
    authenticated = aws_iam_role.authenticated.arn
    unauthenticated = aws_iam_role.unauthenticated.arn
  }
}

