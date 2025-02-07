resource "aws_iam_openid_connect_provider" "terraform_oidc" {
  url = "https://app.terraform.io"

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    "6A55F24DD3DD27CA0279D8DC517467A61FCC1AB9"  # Terraform Cloud's SSL thumbprint
  ]
}
