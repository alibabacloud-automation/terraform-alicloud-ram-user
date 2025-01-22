# RAM group with policies example

Configuration in this directory creates RAM group with users who has specified RAM policies.


# Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Run `terraform destroy` when you don't need these resources.

<!-- 在根目录下运行命令 `terraform-docs markdown . --output-file "./README.md"`，可将所有信息自动填充 -->
<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | 1.239.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ram-group"></a> [ram-group](#module\_ram-group) | ../../modules/ram-group | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_ram_policy.custom-policy-1](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_policy) | resource |
| [alicloud_ram_policy.custom-policy-2](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_policy) | resource |
| [alicloud_ram_policy.custom-policy-3](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_policy) | resource |
| [alicloud_ram_user.default](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_user) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_group_name"></a> [group\_name](#output\_group\_name) | The name of group |
| <a name="output_group_policy_name"></a> [group\_policy\_name](#output\_group\_policy\_name) | The name of policy which bind to group |
| <a name="output_group_user_names"></a> [group\_user\_names](#output\_group\_user\_names) | User name which has be added to group |
<!-- END_TF_DOCS -->
