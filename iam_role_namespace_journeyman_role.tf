data "aws_iam_policy_document" "journeyman_role_document" {
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

resource "aws_iam_role" "journeyman_role" {
  name               = "${local.prefix}-${var.namespace}-journeyman-role"
  assume_role_policy = "${data.aws_iam_policy_document.journeyman_role_document.json}"
  tags               = "${local.tags}"
}

resource "aws_iam_role_policy_attachment" "attach_journeyman_policy" {
  policy_arn = "${aws_iam_policy.namespace_journeyman_policy.arn}"
  role       = "${aws_iam_role.journeyman_role.name}"
}

resource "aws_iam_role_policy_attachment" "attach_readonly_policy" {
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  role       = "${aws_iam_role.journeyman_role.name}"
}
