output "journeyman_assumable_policy_arn" {
  value = "${aws_iam_policy.journeyman_role_assumable_policy.arn}"
}

output "assumable_journeyman_role_name" {
  value = "${aws_iam_role.journeyman_role.name}"
}

output "journeyman_role_arn" {
  value = "${aws_iam_role.journeyman_role.arn}"
}

output "group_name" {
  value = "${aws_iam_group.namespace_journeyman_group.name}"
}
