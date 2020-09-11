data "aws_iam_policy_document" "technical_role_document" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = [
        "arn:aws:iam::${var.account_id}:root",
      ]

      type = "AWS"
    }
  }
}

resource "aws_iam_role" "role" {
  name               = "${local.prefix}-${var.namespace}-technical-role"
  assume_role_policy = "${data.aws_iam_policy_document.technical_role_document.json}"
  tags               = "${local.tags}"
}

resource "aws_iam_role_policy_attachment" "attach_namespace_policy" {
  policy_arn = "${aws_iam_policy.namespace_policy.arn}"
  role       = "${aws_iam_role.role.name}"
}

resource "aws_iam_role_policy_attachment" "attach_readonly_policy" {
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  role       = "${aws_iam_role.role.name}"
}
