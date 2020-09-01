data "aws_iam_policy_document" "namespace_journeyman_role_assumable_document" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    resources = [
      "${aws_iam_role.journeyman_role.arn}",
    ]

    condition {
      test     = "StringEqualsIgnoreCase"
      values   = ["&{aws:username}"]
      variable = "sts:RolesSessionName"
    }
  }

  statement {
    effect    = "Deny"
    actions   = ["*"]
    resources = ["*"]

    condition {
      test     = "NotIpAddressIfExists"
      values   = "${var.cidr_restrictions}"
      variable = "aws:SourceIp"
    }

    condition {
      test     = "BoolIfExists"
      values   = ["false"]
      variable = "aws:ViaAWSService"
    }
  }
}

resource "aws_iam_policy" "journeyman_role_assumable_policy" {
  name   = "${local.prefix}-${local.namespace}-journeyman-assumable-role"
  path   = "${local.policy_path}"
  policy = "${data.aws_iam_policy_document.namespace_journeyman_role_assumable_document.json}"
}
