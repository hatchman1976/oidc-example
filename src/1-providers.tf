resource "aws_iam_openid_connect_provider" "terraform_oidc" {
  url = "https://app.terraform.io"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    "6A55F24DD3DD27CA0279D8DC517467A61FCC1AB9"  # Terraform Cloud's SSL thumbprint
  ]
}

resource "aws_iam_policy" "allow_create_policy" {
  name        = "AllowCreatePolicy"
  description = "Allows the creation of IAM policies"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "iam:CreatePolicy",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach_create_policy_permission" {
  role       = "oidc-example-role"
  policy_arn = aws_iam_policy.allow_create_policy.arn
}


resource "aws_iam_policy" "allow_oidc_creation" {
  name        = "AllowOIDCCreationPolicy"
  description = "Allow creation of OIDC provider"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "iam:CreateOpenIDConnectProvider",
      "Resource": "arn:aws:iam::736654693886:oidc-provider/app.terraform.io"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach_oidc_creation_policy" {
  role       = "oidc-example-role"
  policy_arn = aws_iam_policy.allow_oidc_creation.arn
}
