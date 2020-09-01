resource "aws_iam_group" "namespace_journeyman_group" {
  name = "${local.prefix}-${local.namespace}-journeyman"
}

resource "aws_iam_group_policy_attachment" "attach_journeyman_assumable_policy" {
  group = "${aws_iam_group.namespace_journeyman_group.name}"
  policy_arn = "${aws_iam_policy.journeyman_role_assumable_policy.arn}"
}