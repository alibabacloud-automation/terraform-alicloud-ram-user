Terraform module which create RAM users on Alibaba Cloud.

ram-user 
===========================

简体中文 | [English](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-user/blob/master/README.md)

Terraform模块用于在阿里云上创建RAM用户，同时您可以选择是否创建该用户的`login_profile`和`access_key`并为该用户绑定`policy`。本模块还支持创建RAM组及将用户添加到RAM组中，并为RAM组绑定`policy`等。

## 用法

创建没有任何凭证和权限的ram用户。

```hcl
module "ram-user-example" {
  source = "terraform-alicloud-modules/ram-user/alicloud"
  user_name = "test-user"
}
```

创建RAM用户并授予系统策略权限。

```hcl
module "ram-user-example" {
  source = "terraform-alicloud-modules/ram-user/alicloud"
  user_name = "test-user"
  managed_system_policy_names   = ["AliyunECSReadOnlyAccess", "AliyunRAMReadOnlyAccess"]
}
```

创建RAM用户并授予自定义策略权限，自定义策略需要提前创建。

```hcl
module "ram-user-example" {
  source = "terraform-alicloud-modules/ram-user/alicloud"
  user_name = "test-user"
  managed_custom_policy_names   = ["MyCustomPolicyName"]
}
```

创建RAM用户并允许登陆阿里云Web控制台。

```hcl
module "ram-user-example" {
  source = "terraform-alicloud-modules/ram-user/alicloud"
  user_name                     = "test-user"
  create_ram_user_login_profile = true
  password                      = "Yourpassword_1234"
}
```

创建RAM用户并分配一把访问密钥（Access Key），访问密钥将存储到默认的秘密文件"secret.txt"中。

```hcl
module "ram-user-example" {
  source = "terraform-alicloud-modules/ram-user/alicloud"
  user_name                     = "test-user"
  create_ram_access_key         = true
}
```

创建RAM用户并分配一把访问密钥（Access Key），访问密钥通过指定的PGP公钥加密。

```hcl
module "ram-user-example" {
  source = "terraform-alicloud-modules/ram-user/alicloud"
  user_name                     = "test-user"
  create_ram_access_key         = true
  pgp_key                       = "Your-PGP-Public-Key-Here..."
}
```

## 模块

* [ram-group](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-user/tree/master/modules/ram-group)
* [ram-group-with-assumable-roles-policy](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-user/tree/master/modules/ram-group-with-assumable-roles-policy)


## 示例

* [basic](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-user/tree/master/examples/basic)
* [complete](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-user/tree/master/examples/complete)
* [complete-new](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-user/tree/master/examples/complete-new)
* [ram-group](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-user/tree/master/examples/ram-group)
* [ram-group-new](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-user/tree/master/examples/ram-group-new)
* [ram-group-with-assumable-roles-policy](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-user/tree/master/examples/ram-group-with-assumable-roles-policy)


## 注意事项
本Module从版本v2.0.0开始已经移除掉`create_user_attachment`参数以及`policies`参数，您可以通过`managed_custom_policy_names`以及`managed_system_policy_names`管理自定义策略和系统策略。

本Module从版本v2.0.0开始已经移除掉`existing_user_name`参数，您可以通过`user_name`创建RAM用户。

本Module从版本v1.1.0开始已经移除掉如下的 provider 的显式设置：

```hcl
provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/ram-user"
}
```

如果你依然想在Module中使用这个 provider 配置，你可以在调用Module的时候，指定一个特定的版本，比如 1.0.0:

```hcl
module "ram_user" {
  source                        = "terraform-alicloud-modules/ram-user/alicloud"
  version                       = "1.0.0"
  region                        = "cn-beijing"
  profile                       = "Your-Profile-Name"
  name                          = "test-user"
  create_ram_user_login_profile = true
  // ...
}
```

如果你想对正在使用中的Module升级到 1.1.0 或者更高的版本，那么你可以在模板中显式定义一个相同Region的provider：
```hcl
provider "alicloud" {
  region  = "cn-beijing"
  profile = "Your-Profile-Name"
}
module "ram_user" {
  source                        = "terraform-alicloud-modules/ram-user/alicloud"
  name                          = "test-user"
  create_ram_user_login_profile = true
  // ...
}
```
或者，如果你是多Region部署，你可以利用 `alias` 定义多个 provider，并在Module中显式指定这个provider：

```hcl
provider "alicloud" {
  region  = "cn-beijing"
  profile = "Your-Profile-Name"
  alias   = "bj"
}
module "ram_user" {
  source  = "terraform-alicloud-modules/ram-user/alicloud"
  providers = {
    alicloud = alicloud.bj
  }
  name   = "test-user"
  create_ram_user_login_profile = true
  // ...
}
```

定义完provider之后，运行命令 `terraform init` 和 `terraform apply` 来让这个provider生效即可。

更多provider的使用细节，请移步[How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

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
| [alicloud_ram_access_key.no_pgp](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_access_key) | resource |
| [alicloud_ram_access_key.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_access_key) | resource |
| [alicloud_ram_login_profile.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_login_profile) | resource |
| [alicloud_ram_user.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_user) | resource |
| [alicloud_ram_user_policy_attachment.custom](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_user_policy_attachment) | resource |
| [alicloud_ram_user_policy_attachment.system](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_user_policy_attachment) | resource |
| [random_uuid.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_comments"></a> [comments](#input\_comments) | Comment of the RAM user. This parameter can have a string of 1 to 128 characters. | `string` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create ram user. | `bool` | `true` | no |
| <a name="input_create_ram_access_key"></a> [create\_ram\_access\_key](#input\_create\_ram\_access\_key) | Whether to create ram access key. Default value is 'false'. | `bool` | `false` | no |
| <a name="input_create_ram_user_login_profile"></a> [create\_ram\_user\_login\_profile](#input\_create\_ram\_user\_login\_profile) | Whether to create ram user login profile | `bool` | `false` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | Name of the RAM user which for display | `string` | `null` | no |
| <a name="input_email"></a> [email](#input\_email) | Email of the RAM user. | `string` | `null` | no |
| <a name="input_force_destroy_user"></a> [force\_destroy\_user](#input\_force\_destroy\_user) | When destroying this user, destroy even if it has non-Terraform-managed ram access keys, login profile or MFA devices. Without force\_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed. | `bool` | `false` | no |
| <a name="input_managed_custom_policy_names"></a> [managed\_custom\_policy\_names](#input\_managed\_custom\_policy\_names) | List of names of managed policies of Custom type to attach to RAM user | `list(string)` | `[]` | no |
| <a name="input_managed_system_policy_names"></a> [managed\_system\_policy\_names](#input\_managed\_system\_policy\_names) | List of names of managed policies of System type to attach to RAM user | `list(string)` | `[]` | no |
| <a name="input_mfa_bind_required"></a> [mfa\_bind\_required](#input\_mfa\_bind\_required) | This parameter indicates whether the MFA needs to be bind when the user logs in. | `bool` | `null` | no |
| <a name="input_mobile"></a> [mobile](#input\_mobile) | Phone number of the RAM user. This number must contain an international area code prefix, just look like this: 86-18600008888. | `string` | `null` | no |
| <a name="input_password"></a> [password](#input\_password) | Login password of the user | `string` | `null` | no |
| <a name="input_password_reset_required"></a> [password\_reset\_required](#input\_password\_reset\_required) | This parameter indicates whether the password needs to be reset when the user logs in. | `bool` | `null` | no |
| <a name="input_pgp_key"></a> [pgp\_key](#input\_pgp\_key) | Either a base-64 encoded PGP public key, or a keybase username in the form | `string` | `null` | no |
| <a name="input_secret_file"></a> [secret\_file](#input\_secret\_file) | A file used to store access key and secret key of ther user. | `string` | `null` | no |
| <a name="input_status"></a> [status](#input\_status) | Status of access key | `string` | `"Active"` | no |
| <a name="input_user_name"></a> [user\_name](#input\_user\_name) | Desired name for the ram user. If not set, a default name with prefix 'ram-user-' will be returned. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_key_encrypted_secret"></a> [access\_key\_encrypted\_secret](#output\_access\_key\_encrypted\_secret) | The access key encrypted secret, base64 encoded |
| <a name="output_access_key_id"></a> [access\_key\_id](#output\_access\_key\_id) | The access key ID |
| <a name="output_access_key_key_fingerprint"></a> [access\_key\_key\_fingerprint](#output\_access\_key\_key\_fingerprint) | The fingerprint of the PGP key used to encrypt the secret |
| <a name="output_access_key_secret"></a> [access\_key\_secret](#output\_access\_key\_secret) | The access key secret |
| <a name="output_access_key_status"></a> [access\_key\_status](#output\_access\_key\_status) | Active or Inactive. Keys are initially active, but can be made inactive by other means. |
| <a name="output_pgp_key"></a> [pgp\_key](#output\_pgp\_key) | PGP key used to encrypt sensitive data for this user (if empty, no encryption) |
| <a name="output_this_ram_user_unique_id"></a> [this\_ram\_user\_unique\_id](#output\_this\_ram\_user\_unique\_id) | (Deprecated, use 'user\_id') The unique ID assigned by alicloud |
| <a name="output_this_user_name"></a> [this\_user\_name](#output\_this\_user\_name) | (Deprecated, use 'user\_name') The name of RAM user |
| <a name="output_user_id"></a> [user\_id](#output\_user\_id) | The unique ID assigned by alicloud |
| <a name="output_user_name"></a> [user\_name](#output\_user\_name) | The name of RAM user |
<!-- END_TF_DOCS -->

作者
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

许可
----
Apache 2 Licensed. See LICENSE for full details.

参考
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)
