data "aws_iam_policy_document" "namespace_rds_connect_document" {
  statement {
    effect  = "Allow"
    actions = ["rds-db:connect"]

    resources = [
      "arn:aws:rds-db:*:${var.account_id}:dbuser:${local.prefix}-${local.namespace}*/technical_&{aws:username}",
    ]
  }

  statement {
    effect = "Deny"

    actions = [
      "rds-db:connect",
    ]

    resources = ["*"]

    condition {
      test     = "NotIpAddressIfExists"
      values   = "${var.cidr_restrictions}"
      variable = "aws:SourceIp"
    }
  }
}

resource "aws_iam_policy" "namespace_rds_connect_policy" {
  name   = "${local.prefix}-${local.namespace}-technical-rds-connect-policy"
  path   = "${local.policy_path}"
  policy = "${data.aws_iam_policy_document.namespace_rds_connect_document.json}"
}
