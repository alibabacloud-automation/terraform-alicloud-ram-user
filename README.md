Terraform module which create RAM users on Alibaba Cloud.  
terraform-alicloud-ram-user
--------------------------

English | [简体中文](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-user/blob/master/README-CN.md)

Terraform module is used to create one or multiple RAM users on Alibaba Cloud. It is possible to choose whether to create the user's `login_profile` and `access_key` and bind `policy` to this user.

These types of resources are supported:

* [RAM user](https://www.terraform.io/docs/providers/alicloud/r/ram_user.html)
* [RAM access key](https://www.terraform.io/docs/providers/alicloud/r/ram_access_key.html)
* [RAM login profile](https://www.terraform.io/docs/providers/alicloud/r/ram_login_profile.html)
* [RAM user policy attachment](https://www.terraform.io/docs/providers/alicloud/r/ram_user_policy_attachment.html)


## Terraform versions

The Module requires Terraform 0.12.6 and Terraform Provider AliCloud 1.56.0+.

## Usage

### create a new ram user

Create a ram user without any access permission.

```hcl
module "ram-user" {
  source = "terraform-alicloud-modules/ram-user/alicloud"

  users = [{
      name         = "test-user-1",
      display_name = "Test User 1",
      mobile       = null,
      email        = null,
      comments     = null
    },
    {
      name         = "test-user-2",
      display_name = "Test User 2",
      mobile       = null,
      email        = null,
      comments     = "A service account"
    }
  ]

}
```
Setting `login_profiles` allows the ram users to login in the web console.

```hcl
module "ram_user" {
  source = "terraform-alicloud-modules/ram-user/alicloud"

  users = [{
      name         = "test-user-1",
      display_name = "Test User 1",
      mobile       = null,
      email        = null,
      comments     = null
    },
    {
      name         = "test-user-2",
      display_name = "Test User 2",
      mobile       = null,
      email        = null,
      comments     = "A service account"
    }
  ]
   
  login_profiles = [{
    user_name               = "test-user-1",
    password                = "QWEsasa!676",
    password_reset_required = false,
    mfa_bind_required       = false
    }
  ]

 }
```

Setting `access_keys` allocates access key and secret key to the ram users
, and stored them in the secret file of each user `${name}.key`.
For convenience, the secret file is output to the console.
Depending on the terraform worker, the secret may be available only one time before getting deleted.

```hcl
module "ram_user" {
   source                = "terraform-alicloud-modules/ram-user/alicloud"

  users = [{
      name         = "test-user-1",
      display_name = "Test User 1",
      mobile       = null,
      email        = null,
      comments     = null
    },
    {
      name         = "test-user-2",
      display_name = "Test User 2",
      mobile       = null,
      email        = null,
      comments     = "A service account"
    }
  ]

  access_keys = ["test-user-1"]

 }
```

Create a RAM user with `login profile`, `access key` and `policies`.

```hcl
module "ram-user" {
  source = "terraform-alicloud-modules/ram-user/alicloud"

  ################################
  # RAM user
  ################################
  users = [{
      name         = "test-user-1",
      display_name = "Test User 1",
      mobile       = null,
      email        = null,
      comments     = null
    },
    {
      name         = "test-user-2",
      display_name = "Test User 2",
      mobile       = null,
      email        = null,
      comments     = "A service account"
    }
  ]
  
  ################################
  # RAM login profile/RAM access key
  ################################
  login_profiles = [{
    user_name               = "test-user-1",
    password                = "QWEsasa!676",
    password_reset_required = false,
    mfa_bind_required       = false
    }
  ]

  access_keys = ["test-user-1"]
  
  ################################
  # RAM user policy attachment
  ################################
  system_policies = [
    "AdministratorAccess"
  ]

  custom_policies = ["manage-slb-and-eip-resource"]

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

## Examples

* [complete example](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-user/tree/master/examples/complete)

Authors
-------
Created and maintained by Zhou qilin(z17810666992@163.com), He Guimin(@xiaozhu36, heguimin36@163.com).

Contributors:
* Brian Mori (@brianmori)

License
----
Apache 2 Licensed. See LICENSE for full details.

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)

