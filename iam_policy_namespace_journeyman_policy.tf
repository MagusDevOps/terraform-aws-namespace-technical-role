data "aws_iam_policy_document" "namespace_journeyman_policy_document" {
  statement {
    sid = "Crypto"

    actions = [
      "kms:Decrypt",
      "kms:Generate*",
      "kms:Verify",
      "kms:Encrypt",
    ]

    resources = [
      "arn:aws:kms:*:${var.account_id}:key/${local.prefix}/${local.namespace}/*",
    ]
  }

  statement {
    sid = "topicPublishing"

    actions = [
      "sns:Publish",
    ]

    resources = [
      "arn:aws:sns:*:${var.account_id}:${local.sns_prefix}*",
    ]
  }

  statement {
    sid = "queuing"

    actions = [
      "sqs:ReceiveMessage",
      "sqs:ChangeMessageVisibility",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes",
    ]

    resources = [
      "arn:aws:sqs:*:${var.account_id}:${local.queue_prefix}*",
    ]
  }

  statement {
    sid = "secrets"

    actions = [
      "secretsmanager:GetResourcePolicy",
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecretVersionIds",
      "secretsmanager:PutSecretValue",
      "secretsmanager:RestoreSecret",
      "secretsmanager:UpdateSecret",
    ]

    resources = [
      "arn:aws:secretsmanager:*:${var.account_id}:secret:${local.prefix}/${local.namespace}/*",
    ]
  }

  statement {
    sid = "secretsParameters"

    actions = [
      "ssm:GetParameter*",
      "ssm:PutParameter",
    ]

    resources = [
      "arn:aws:ssm:*:${var.account_id}:parameter:${local.prefix}/${local.namespace}/*",
    ]
  }

  statement {
    sid = "dynamo"

    actions = [
      "dynamodb:Batch*",
      "dynamodb:Condition*",
      "dynamodb:DeleteItem",
      "dynamodb:Describe*",
      "dynamodb:Get*",
      "dynamodb:Put*",
      "dynamodb:Scan",
      "dynamodb:UpdateItem",
    ]

    resources = [
      "arn:aws:dynamodb:*:${var.account_id}:table/${local.prefix}_${local.namespace}*",
    ]
  }

  statement {
    sid = "s3"

    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
    ]

    resources = [
      "arn:aws:s3:::${local.prefix}-${local.namespace}*",
    ]
  }
}

resource "aws_iam_policy" "namespace_journeyman_policy" {
  name   = "${local.prefix}-${local.namespace}-journeyman-policy"
  path   = "${local.policy_path}"
  policy = "${data.aws_iam_policy_document.namespace_journeyman_policy_document.json}"
}
