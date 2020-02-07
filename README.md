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

## Terraform versions

The Module requires Terraform 0.12 and Terraform Provider AliCloud 1.56.0+.

## Usage

### create a new ram user

Create a ram user without any access permission.

```hcl
module "ram-user" {
  source = "terraform-alicloud-modules/ram-user/alicloud"
  name   = "test-user"
}
```
Setting `create_ram_user_login_profile` to true can allow the ram user login the web console.

```hcl
module "ram_user" {
   source = "terraform-alicloud-modules/ram-user/alicloud"

   name                          = "test-user"
   create_ram_user_login_profile = true
   password                      = "Yourpassword_1234"
 }
```

Setting `create_ram_access_key` to true can allocate a access key and secret key to the ram user
, and them will store into the default secret file `secret.txt`.

```hcl
module "ram_user" {
   source                = "terraform-alicloud-modules/ram-user/alicloud"

   name                  = "test-user"
   create_ram_access_key = true
 }
```

Create a RAM user with `login profile`, `access key` and `policies`.

```hcl
module "ram-user" {
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
      policy_names = join(",", module.ram_policy.this_policy_name)
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


Authors
-------
Created and maintained by Zhou qilin(z17810666992@163.com), He Guimin(@xiaozhu36, heguimin36@163.com).

License
----
Apache 2 Licensed. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)

