variable "account_id" {
  type        = "string"
  description = "AWS account ID"
}

variable "additional_tags" {
  type        = "map"
  default     = {}
  description = "A map of additional tags"
}

variable "prefix_tag_key" {
  type        = "string"
  default     = "environment"
  description = "the prefix tag key defaults to 'environment'"
}

variable "prefix" {
  type        = "string"
  description = "a string that provides a differentiation an environment"
}

variable "namespace_tag_key" {
  type        = "string"
  default     = "namespace"
  description = "tag key for the namespace variables"
}

variable "namespace" {
  type        = "string"
  description = "a name that provides a logical grouping of resources"
}

variable "cidr_restrictions" {
  type        = "list"
  default     = ["0.0.0.0/0"]
  description = "a list of CIDRs that a user can execute this policy from"
}

locals {
  namespace    = "${lower(var.namespace)}"
  prefix       = "${lower(var.prefix)}"
  queue_prefix = "${upper(var.prefix)}_${local.namespace}"
  sns_prefix   = "${upper(var.prefix)}_${local.namespace}"
  policy_path  = "/${local.prefix}/${local.namespace}/"

  required_tags = "${map(
    var.prefix_tag_key, local.prefix,
    var.namespace_tag_key, local.namespace
  )}"

  tags = "${merge(var.additional_tags, local.required_tags)}"
}
