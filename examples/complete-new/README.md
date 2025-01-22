# RAM user example

This example illustrates how to create a more complicated user.

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

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | 1.235.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ram-user-example"></a> [ram-user-example](#module\_ram-user-example) | ../.. | n/a |

## Resources

| Name | Type |
|------|------|
| [alicloud_ram_policy.custom-policy-1](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_policy) | resource |
| [random_integer.default](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_key_encrypted_secret"></a> [access\_key\_encrypted\_secret](#output\_access\_key\_encrypted\_secret) | The access key encrypted secret, base64 encoded |
| <a name="output_access_key_id"></a> [access\_key\_id](#output\_access\_key\_id) | The access key ID |
| <a name="output_access_key_key_fingerprint"></a> [access\_key\_key\_fingerprint](#output\_access\_key\_key\_fingerprint) | The fingerprint of the PGP key used to encrypt the secret |
| <a name="output_access_key_secret"></a> [access\_key\_secret](#output\_access\_key\_secret) | The access key secret |
| <a name="output_access_key_status"></a> [access\_key\_status](#output\_access\_key\_status) | Active or Inactive. Keys are initially active, but can be made inactive by other means. |
| <a name="output_pgp_key"></a> [pgp\_key](#output\_pgp\_key) | PGP key used to encrypt sensitive data for this user (if empty, no encryption) |
| <a name="output_this_user_policy_name"></a> [this\_user\_policy\_name](#output\_this\_user\_policy\_name) | (Deprecated, only works with the deprecated variable 'policies') The name of RAM policy which bind to RAM user |
| <a name="output_user_id"></a> [user\_id](#output\_user\_id) | The unique ID assigned by alicloud |
| <a name="output_user_name"></a> [user\_name](#output\_user\_name) | The name of RAM user |
<!-- END_TF_DOCS -->
