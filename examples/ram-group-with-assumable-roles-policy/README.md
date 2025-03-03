# RAM group with assumable roles policy example

Configuration in this directory creates RAM group with users who are allowed to assume RAM roles.


# Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Run `terraform destroy` when you don't need these resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_example"></a> [example](#module\_example) | ../../modules/ram-group-with-assumable-roles-policy | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_ram_role.prepared-role](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_role) | resource |
| [alicloud_ram_user.prepared-user-1](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_user) | resource |
| [alicloud_ram_user.prepared-user-2](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_user) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_assumable_roles"></a> [assumable\_roles](#output\_assumable\_roles) | List of ARNs of RAM roles which members of RAM group can assume |
| <a name="output_group_name"></a> [group\_name](#output\_group\_name) | RAM group name |
| <a name="output_group_users"></a> [group\_users](#output\_group\_users) | List of RAM users in RAM group |
| <a name="output_policy_name"></a> [policy\_name](#output\_policy\_name) | Assume role policy ARN of RAM group |
<!-- END_TF_DOCS -->
