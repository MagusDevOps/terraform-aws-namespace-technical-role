resource "aws_iam_group" "namespace_group" {
  name = "${local.prefix}-${local.namespace}-technical"
}

resource "aws_iam_group_policy_attachment" "attach_assumable_policy" {
  group      = "${aws_iam_group.namespace_group.name}"
  policy_arn = "${aws_iam_policy.role_assumable_policy.arn}"
}

resource "aws_iam_group_policy_attachment" "attach_rds_connect_policy" {
  group      = "${aws_iam_group.namespace_group.name}"
  policy_arn = "${aws_iam_policy.namespace_rds_connect_policy.arn}"
}
