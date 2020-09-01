# terraform-aws-namespace-journeyman-role
## Requirements

No requirements.

## Providers

The following providers are used by this module:

- aws

## Required Inputs

The following input variables are required:

### account\_id

Description: AWS account ID

Type: `string`

### namespace

Description: a name that provides a logical grouping of resources

Type: `string`

### prefix

Description: a string that provides a differentiation an environment

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### additional\_tags

Description: A map of additional tags

Type: `map`

Default: `{}`

### cidr\_restrictions

Description: a list of CIDRs that a user can execute this policy from

Type: `list`

Default:

```json
[
  "0.0.0.0/0"
]
```

### namespace\_tag\_key

Description: tag key for the namespace variables

Type: `string`

Default: `"namespace"`

### prefix\_tag\_key

Description: the prefix tag key defaults to 'environment'

Type: `string`

Default: `"environment"`

## Outputs

The following outputs are exported:

### assumable\_journeyman\_role\_name

### journeyman\_assumable\_policy\_arn

### journeyman\_role\_arn

### group\_name