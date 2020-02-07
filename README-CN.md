terraform-alicloud-ram-user 
===========================

Terraform模块用于在阿里云上创建RAM用户，同时您可以选择是否创建该用户的`login_profile`和`access_key`并为该用户绑定`policy`。本模块还支持创建RAM组及将用户添加到RAM组中，并为RAM组绑定`policy`等。

支持以下类型的资源：

* [RAM user](https://www.terraform.io/docs/providers/alicloud/r/ram_user.html)
* [RAM group](https://www.terraform.io/docs/providers/alicloud/r/ram_group.html)
* [RAM access key](https://www.terraform.io/docs/providers/alicloud/r/ram_access_key.html)
* [RAM login profile](https://www.terraform.io/docs/providers/alicloud/r/ram_login_profile.html)
* [RAM group membership](https://www.terraform.io/docs/providers/alicloud/r/ram_group_membership.html)
* [RAM user policy attachment](https://www.terraform.io/docs/providers/alicloud/r/ram_user_policy_attachment.html)
* [RAM group policy attachment](https://www.terraform.io/docs/providers/alicloud/r/ram_group_policy_attachment.html)

## Terraform 版本

本 Module 要求使用 Terraform 0.12 和 阿里云 Provider 1.56.0+。

## 用法

### 创建一个新的RAM用户

创建没有任何访问权限的ram用户。

```hcl
module "ram-user" {
  source = "terraform-alicloud-modules/ram-user/alicloud"
  name   = "test-user"
}
```
将create_ram_user_login_profile设置为true可以允许ram用户登录Web控制台。

```hcl
module "ram_user" {
   source = "terraform-alicloud-modules/ram-user/alicloud"

   name                          = "test-user"
   create_ram_user_login_profile = true
   password                      = "Yourpassword_1234"
 }
```

将create_ram_access_key设置为true可以为ram用户分配访问密钥和秘密密钥，它们将存储到默认的秘密文件"secret.txt"中。

```hcl
module "ram_user" {
   source                = "terraform-alicloud-modules/ram-user/alicloud"

   name                  = "test-user"
   create_ram_access_key = true
 }
```

创建一个完整的RAM用户。

```hcl
module "ram-user" {
  source = "terraform-alicloud-modules/ram-user/alicloud"

  ################################
  # 创建RAM用户
  ################################
  user_name    = "test-user"
  mobile       = "86-18688888888"
  email        = "13366668888@163.com"
  comments     = "this is a test user"
  
  ################################
  # 创建RAM用户的 login profile和 access key
  ################################
  create_ram_access_key         = true
  password                      = "Yourpassword_1234"
  create_ram_user_login_profile = true
  
  ################################
  # 为RAM用户绑定系统或自定义策略
  ################################
  create_user_attachment = true
  policies = [
    # 绑定系统策略
    {
      policy_names = join(",", ["AliyunVPCFullAccess", "AliyunKafkaFullAccess"])
      policy_type  = "System"
    },
    # 绑定自定义策略
    {
      policy_names = "VpcListTagResources,RamPolicyForZhouqilin"
      policy_type  = "Custom"
    },
    # 绑定自定义策略
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

## 模块

* [ram-group 模块](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-user/tree/master/modules/ram-group)


## 示例

* [ram-user 完整示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-user/tree/master/examples/complete)
* [ram-group 示例](https://github.com/terraform-alicloud-modules/terraform-alicloud-ram-user/tree/master/examples/ram-group)


作者
-------
Created and maintained by Zhou qilin(z17810666992@163.com), He Guimin(@xiaozhu36, heguimin36@163.com)

许可
----
Apache 2 Licensed. See LICENSE for full details.

参考
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)

