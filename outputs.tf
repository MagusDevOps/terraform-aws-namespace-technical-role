output "technical_assumable_policy_arn" {
  value = "${aws_iam_policy.technical_role_assumable_policy.arn}"
}

output "assumable_technical_role_name" {
  value = "${aws_iam_role.technical_role.name}"
}

output "technical_role_arn" {
  value = "${aws_iam_role.technical_role.arn}"
}

output "group_name" {
  value = "${aws_iam_group.namespace_technical_group.name}"
}
