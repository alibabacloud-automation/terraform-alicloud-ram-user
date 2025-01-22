Terraform module which create RAM users on Alibaba Cloud.  
terraform-alicloud-ram-user
--------------------------

English | [简体中文](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-user/blob/master/README-CN.md)

Terraform module is used to create a RAM user on Alibaba Cloud, while you can choose whether to create the user's `login_profile` and `access_key` and bind `policy` to this user. This module also supports creating RAM group, adding users to RAM group, and binding `policy` to RAM group.

These types of resources are supported:

* [RAM user](https://www.terraform.io/docs/providers/alicloud/r/ram_user.html)
* [RAM group](https://www.terraform.io/docs/providers/alicloud/r/ram_group.html)
* [RAM access key](https://www.terraform.io/docs/providers/alicloud/r/ram_access_key.html)
* [RAM login profile](https://www.terraform.io/docs/providers/alicloud/r/ram_login_profile.html)
* [RAM group membership](https://www.terraform.io/docs/providers/alicloud/r/ram_group_membership.html)
* [RAM user policy attachment](https://www.terraform.io/docs/providers/alicloud/r/ram_user_policy_attachment.html)
* [RAM group policy attachment](https://www.terraform.io/docs/providers/alicloud/r/ram_group_policy_attachment.html)

## Usage

### create a new ram user

Create a ram user without any access permission.

```hcl
module "ram_user" {
  source    = "terraform-alicloud-modules/ram-user/alicloud"
  user_name = "test-user"
}
```
Setting `create_ram_user_login_profile` to true can allow the ram user login the web console.

```hcl
module "ram_user" {
  source = "terraform-alicloud-modules/ram-user/alicloud"

  user_name                     = "test-user"
  create_ram_user_login_profile = true
  password                      = "Yourpassword_1234"
}
```

Setting `create_ram_access_key` to true can allocate a access key and secret key to the ram user
, and them will store into the default secret file `secret.txt`.

```hcl
module "ram_user" {
  source = "terraform-alicloud-modules/ram-user/alicloud"

  user_name             = "test-user"
  create_ram_access_key = true
}
```

Create a RAM user with `login profile`, `access key` and `policies`.

```hcl
module "ram_user" {
  source = "terraform-alicloud-modules/ram-user/alicloud"

  ################################
  # RAM user
  ################################
  user_name    = "test-user"
  mobile       = "86-18688888888"
  email        = "13366668888@163.com"
  comments     = "this is a test user"
  
  ################################
  # RAM login profile/RAM access key
  ################################
  create_ram_access_key         = true
  password                      = "Yourpassword_1234"
  create_ram_user_login_profile = true
  
  ################################
  # RAM user policy attachment
  ################################
  create_user_attachment = true
  policies = [
    # Binding a system policy.
    {
      policy_names = join(",", ["AliyunVPCFullAccess", "AliyunKafkaFullAccess"])
      policy_type  = "System"
    },
    # When binding custom policy, make sure this policy has been created.
    {
      policy_names = "VpcListTagResources,RamPolicyForZhouqilin"
      policy_type  = "Custom"
    },
    # Create policy and bind the ram user.
    {
      policy_names = join(",", ["manage-slb-and-eip-resource", "manage-ecs-vpc-and-vswitch-resource"])
    }
  ]
}
module "ram_policy" {
  source = "terraform-alicloud-modules/ram-policy/alicloud"
  policies = [
    {
      name            = "manage-slb-and-eip-resource"
      defined_actions = join(",", ["slb-all", "vpc-all", "vswitch-all"])
      actions         = join(",", ["vpc:AssociateEipAddress", "vpc:UnassociateEipAddress"])
      resources       = join(",", ["acs:vpc:*:*:eip/eip-12345", "acs:slb:*:*:*"])
    },
    {
      #actions is the action of custom specific resource.
      #resources is the specific object authorized to customize.
      name      = "manage-ecs-vpc-and-vswitch-resource"
      actions   = join(",", ["ecs:ModifyInstanceAttribute", "vpc:ModifyVpc", "vswitch:ModifyVSwitch"])
      resources = join(",", ["acs:ecs:*:*:instance/i-001", "acs:vpc:*:*:vpc/v-001", "acs:vpc:*:*:vswitch/vsw-001"])
      effect    = "Deny"
    }    
  ]
}
```

## Modules
* [ram-group module](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-user/tree/master/modules/ram-group)

## Examples

* [complete example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-user/tree/master/examples/complete)
* [ram-group example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-user/tree/master/examples/ram-group)

## Notes
From the version v1.1.0, the module has removed the following `provider` setting:

```hcl
provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/ram-user"
}
```

If you still want to use the `provider` setting to apply this module, you can specify a supported version, like 1.0.0:

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

If you want to upgrade the module to 1.1.0 or higher in-place, you can define a provider which same region with
previous region:

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
or specify an alias provider with a defined region to the module using `providers`:

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

and then run `terraform init` and `terraform apply` to make the defined provider effect to the existing module state.

More details see [How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

<!-- 在根目录下运行命令 `terraform-docs markdown . --output-file "./README.md"`，可将所有信息自动填充 -->
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
| [alicloud_ram_user_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_user_policy_attachment) | resource |
| [random_uuid.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_comments"></a> [comments](#input\_comments) | Comment of the RAM user. This parameter can have a string of 1 to 128 characters. | `string` | `""` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether to create ram user. | `bool` | `true` | no |
| <a name="input_create_ram_access_key"></a> [create\_ram\_access\_key](#input\_create\_ram\_access\_key) | Whether to create ram access key. Default value is 'false'. | `bool` | `false` | no |
| <a name="input_create_ram_user_login_profile"></a> [create\_ram\_user\_login\_profile](#input\_create\_ram\_user\_login\_profile) | Whether to create ram user login profile | `bool` | `false` | no |
| <a name="input_create_user_attachment"></a> [create\_user\_attachment](#input\_create\_user\_attachment) | (Deprecated, works with the deprecated variable 'policies') Whether to attach RAM policy to RAM user. Default value is 'false'. | `bool` | `false` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | Name of the RAM user which for display | `string` | `""` | no |
| <a name="input_email"></a> [email](#input\_email) | Email of the RAM user. | `string` | `""` | no |
| <a name="input_existing_user_name"></a> [existing\_user\_name](#input\_existing\_user\_name) | (Deprecated) The name of an existing RAM group. If set, 'create' will be ignored. | `string` | `""` | no |
| <a name="input_force_destroy_user"></a> [force\_destroy\_user](#input\_force\_destroy\_user) | When destroying this user, destroy even if it has non-Terraform-managed ram access keys, login profile or MFA devices. Without force\_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed. | `bool` | `false` | no |
| <a name="input_managed_custom_policy_names"></a> [managed\_custom\_policy\_names](#input\_managed\_custom\_policy\_names) | List of names of managed policies of Custom type to attach to RAM user | `list(string)` | `[]` | no |
| <a name="input_managed_system_policy_names"></a> [managed\_system\_policy\_names](#input\_managed\_system\_policy\_names) | List of names of managed policies of System type to attach to RAM user | `list(string)` | `[]` | no |
| <a name="input_mfa_bind_required"></a> [mfa\_bind\_required](#input\_mfa\_bind\_required) | This parameter indicates whether the MFA needs to be bind when the user first logs in. Default value is 'false'. | `bool` | `false` | no |
| <a name="input_mobile"></a> [mobile](#input\_mobile) | Phone number of the RAM user. This number must contain an international area code prefix, just look like this: 86-18600008888. | `string` | `""` | no |
| <a name="input_password"></a> [password](#input\_password) | Login password of the user | `string` | `""` | no |
| <a name="input_password_reset_required"></a> [password\_reset\_required](#input\_password\_reset\_required) | This parameter indicates whether the password needs to be reset when the user first logs in. Default value is 'false'. | `bool` | `false` | no |
| <a name="input_pgp_key"></a> [pgp\_key](#input\_pgp\_key) | Either a base-64 encoded PGP public key, or a keybase username in the form | `string` | `""` | no |
| <a name="input_policies"></a> [policies](#input\_policies) | (Deprecated, use 'managed\_custom\_policy\_names' and 'managed\_system\_policy\_names') List of the policies that binds the user. Each item can contains keys: 'policy\_name'(the name of policy that used to bind the user), 'policy\_type'(the type of ram policies, System or Custom, default to Custom.). | `list(map(string))` | `[]` | no |
| <a name="input_profile"></a> [profile](#input\_profile) | (Deprecated from version 1.1.0) The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD\_PROFILE environment variable. | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | (Deprecated from version 1.1.0) The region used to launch this module resources. | `string` | `""` | no |
| <a name="input_secret_file"></a> [secret\_file](#input\_secret\_file) | A file used to store access key and secret key of ther user. | `string` | `""` | no |
| <a name="input_shared_credentials_file"></a> [shared\_credentials\_file](#input\_shared\_credentials\_file) | (Deprecated from version 1.1.0) This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used. | `string` | `""` | no |
| <a name="input_skip_region_validation"></a> [skip\_region\_validation](#input\_skip\_region\_validation) | (Deprecated from version 1.1.0) Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet). | `bool` | `false` | no |
| <a name="input_status"></a> [status](#input\_status) | Status of access key | `string` | `"Active"` | no |
| <a name="input_user_name"></a> [user\_name](#input\_user\_name) | Desired name for the ram user. If not set, a default name with prefix 'ram-user-' will be returned. | `string` | `""` | no |

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
| <a name="output_this_user_policy_name"></a> [this\_user\_policy\_name](#output\_this\_user\_policy\_name) | (Deprecated, only works with the deprecated variable 'policies') The name of RAM policy which bind to RAM user |
| <a name="output_user_id"></a> [user\_id](#output\_user\_id) | The unique ID assigned by alicloud |
| <a name="output_user_name"></a> [user\_name](#output\_user\_name) | The name of RAM user |
<!-- END_TF_DOCS -->

Authors
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

License
----
Apache 2 Licensed. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)
