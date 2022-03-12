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

## 注意事项
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

## Terraform 版本

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.56.0 |

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