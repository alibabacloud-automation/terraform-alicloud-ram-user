# Creates RAM group with specified RAM policies, and add users into a group.

## Usage

```hcl
module "ram_group_with_policies" {
    source  = "terraform-alicloud-modules/ram-user/alicloud//modules/ram-group-with-policies"

  # omitted...
}
```

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

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_ram_group.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_group) | resource |
| [alicloud_ram_group_membership.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_group_membership) | resource |
| [alicloud_ram_group_policy_attachment.managed_custom](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_group_policy_attachment) | resource |
| [alicloud_ram_group_policy_attachment.managed_system](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_group_policy_attachment) | resource |
| [alicloud_ram_group_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_group_policy_attachment) | resource |
| [random_uuid.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_comments"></a> [comments](#input\_comments) | Comment of the RAM group. This parameter can have a string of 1 to 128 characters. | `string` | `"this group was created by terrafom module ram-user/modules/ram-group."` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create RAM group. | `bool` | `true` | no |
| <a name="input_existing_group_name"></a> [existing\_group\_name](#input\_existing\_group\_name) | (Deprecated) The name of an existing RAM group. If set, 'create' will be ignored. | `string` | `null` | no |
| <a name="input_force_destroy_group"></a> [force\_destroy\_group](#input\_force\_destroy\_group) | This parameter is used for resource destroy. | `bool` | `false` | no |
| <a name="input_group_name"></a> [group\_name](#input\_group\_name) | Name of the RAM group. If not set, a default name with prefix 'ram-group-' will be returned. | `string` | `null` | no |
| <a name="input_managed_custom_policy_names"></a> [managed\_custom\_policy\_names](#input\_managed\_custom\_policy\_names) | List of names of managed policies of Custom type to attach to RAM group | `list(string)` | `[]` | no |
| <a name="input_managed_system_policy_names"></a> [managed\_system\_policy\_names](#input\_managed\_system\_policy\_names) | List of names of managed policies of System type to attach to RAM group | `list(string)` | `[]` | no |
| <a name="input_policies"></a> [policies](#input\_policies) | (Deprecated, use 'managed\_custom\_policy\_names' and 'managed\_system\_policy\_names') List of the policies that binds the role. Each item can contains keys: 'policy\_name'(the name of policy that used to bind the role), 'policy\_type'(the type of ram policies, System or Custom, default to Custom.). | `list(map(string))` | `[]` | no |
| <a name="input_user_names"></a> [user\_names](#input\_user\_names) | List of user name which will be added to group | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_group_name"></a> [group\_name](#output\_group\_name) | The name of group |
| <a name="output_group_user_names"></a> [group\_user\_names](#output\_group\_user\_names) | user name which has be added to group |
| <a name="output_this_group_name"></a> [this\_group\_name](#output\_this\_group\_name) | (Deprecated, use 'group\_name') The name of group |
| <a name="output_this_group_policy_name"></a> [this\_group\_policy\_name](#output\_this\_group\_policy\_name) | (Deprecated, works with the deprecated variable 'policies') The name of policy which bind to group |
| <a name="output_this_group_user_names"></a> [this\_group\_user\_names](#output\_this\_group\_user\_names) | (Deprecated, use 'group\_user\_names') user name which has be added to group |
<!-- END_TF_DOCS -->
