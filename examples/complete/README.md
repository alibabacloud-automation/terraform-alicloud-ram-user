# Complete

Configuration in this directory creates RAM user with specified password, a pair of access key and access secret, which will be stored in './secret.txt'. This user can be attached with ram policies.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

This example provides the tf variables file in the folder `tfvars`. If you want to create or update this example,
you can run this example as the following commands:
```bash
$ terraform plan -var-file=tfvars/01-update.tfvars
$ terraform apply -var-file=tfvars/01-update.tfvars
```

Also, you can add more variables files in the folder `tfvars`.

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
| <a name="module_ram_access_key"></a> [ram\_access\_key](#module\_ram\_access\_key) | ../.. | n/a |
| <a name="module_ram_group"></a> [ram\_group](#module\_ram\_group) | ../../modules/ram-group | n/a |
| <a name="module_ram_group_membership"></a> [ram\_group\_membership](#module\_ram\_group\_membership) | ../../modules/ram-group | n/a |
| <a name="module_ram_group_policy_attachment"></a> [ram\_group\_policy\_attachment](#module\_ram\_group\_policy\_attachment) | ../../modules/ram-group | n/a |
| <a name="module_ram_login_profile"></a> [ram\_login\_profile](#module\_ram\_login\_profile) | ../.. | n/a |
| <a name="module_ram_user"></a> [ram\_user](#module\_ram\_user) | ../.. | n/a |
| <a name="module_ram_user_policy_attachment"></a> [ram\_user\_policy\_attachment](#module\_ram\_user\_policy\_attachment) | ../.. | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_ram_policy.custom-policy-1](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_comments"></a> [comments](#input\_comments) | Comment of the RAM user. This parameter can have a string of 1 to 128 characters. | `string` | `"tf-testacc-comments"` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | Name of the RAM user which for display | `string` | `"tf-testacc-display-name"` | no |
| <a name="input_email"></a> [email](#input\_email) | Email of the RAM user. | `string` | `"168@gmail.com"` | no |
| <a name="input_force_destroy_user"></a> [force\_destroy\_user](#input\_force\_destroy\_user) | When destroying this user, destroy even if it has non-Terraform-managed ram access keys, login profile or MFA devices. Without force\_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed. | `bool` | `false` | no |
| <a name="input_mfa_bind_required"></a> [mfa\_bind\_required](#input\_mfa\_bind\_required) | This parameter indicates whether the MFA needs to be bind when the user first logs in. Default value is 'false'. | `bool` | `false` | no |
| <a name="input_mobile"></a> [mobile](#input\_mobile) | Phone number of the RAM user. This number must contain an international area code prefix, just look like this: 86-18600008888. | `string` | `"18666666666"` | no |
| <a name="input_password"></a> [password](#input\_password) | Login password of the user | `string` | `"YourPassword123!"` | no |
| <a name="input_password_reset_required"></a> [password\_reset\_required](#input\_password\_reset\_required) | This parameter indicates whether the password needs to be reset when the user first logs in. Default value is 'false'. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_group_name"></a> [group\_name](#output\_group\_name) | The name of group |
| <a name="output_group_policy_name"></a> [group\_policy\_name](#output\_group\_policy\_name) | The name of policy which bind to group |
| <a name="output_group_user_names"></a> [group\_user\_names](#output\_group\_user\_names) | user name which has be added to group |
| <a name="output_this_user_policy_name"></a> [this\_user\_policy\_name](#output\_this\_user\_policy\_name) | (Deprecated, only works with the deprecated variable 'policies') The name of RAM policy which bind to RAM user |
| <a name="output_user_id"></a> [user\_id](#output\_user\_id) | The unique ID assigned by alicloud |
| <a name="output_user_name"></a> [user\_name](#output\_user\_name) | The name of RAM user |
<!-- END_TF_DOCS -->
