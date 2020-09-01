resource "aws_iam_group" "namespace_technical_group" {
  name = "${local.prefix}-${local.namespace}-technical"
}

resource "aws_iam_group_policy_attachment" "attach_technical_assumable_policy" {
  group      = "${aws_iam_group.namespace_technical_group.name}"
  policy_arn = "${aws_iam_policy.technical_role_assumable_policy.arn}"
}
