module "ram_user" {
  source = "../.."

  # RAM user
  create = true

  user_name          = "tf-testacc-user-2022"
  display_name       = var.display_name
  mobile             = var.mobile
  email              = var.email
  comments           = var.comments
  force_destroy_user = var.force_destroy_user

  # RAM login profile
  create_ram_user_login_profile = false

  # RAM access key
  create_ram_access_key = false

  # RAM user policy attachment
  create_user_attachment = false

}

module "ram_login_profile" {
  source = "../.."

  # RAM user
  create = false

  # RAM login profile
  create_ram_user_login_profile = true

  existing_user_name      = module.ram_user.this_user_name
  password                = var.password
  password_reset_required = var.password_reset_required
  mfa_bind_required       = var.mfa_bind_required

  # RAM access key
  create_ram_access_key = false

  # RAM user policy attachment
  create_user_attachment = false

}

module "ram_access_key" {
  source = "../.."

  # RAM user
  create = false

  # RAM login profile
  create_ram_user_login_profile = false

  # RAM access key
  create_ram_access_key = true

  existing_user_name = module.ram_user.this_user_name
  secret_file        = "secret.txt"

  # RAM user policy attachment
  create_user_attachment = false

}

module "ram_user_policy_attachment" {
  source = "../.."

  # RAM user
  create = false

  # RAM login profile
  create_ram_user_login_profile = false

  # RAM access key
  create_ram_access_key = false

  # RAM user policy attachment
  create_user_attachment = true

  existing_user_name = module.ram_user.this_user_name
  policies = [
    {
      policy_names = module.ram_policy.this_policy_name[0]
      policy_type  = "Custom"
    }
  ]

}

module "ram_group" {
  source = "../../modules/ram-group"

  # RAM group
  create = true

  group_name          = "tf-testacc-group"
  comments            = var.comments
  force_destroy_group = var.force_destroy_user

}

module "ram_group_membership" {
  source = "../../modules/ram-group"

  # RAM group
  create = false

  # RAM group membership
  existing_group_name = module.ram_group.this_group_name[0]
  user_names          = [module.ram_user.this_user_name]

}

module "ram_group_policy_attachment" {
  source = "../../modules/ram-group"

  # RAM group
  create = false

  # RAM group policy attachements
  existing_group_name = module.ram_group.this_group_name[0]
  policies = [
    {
      policy_names = module.ram_policy.this_policy_name[0]
      policy_type  = "Custom"
    }
  ]

}

module "ram_policy" {
  source = "terraform-alicloud-modules/ram-policy/alicloud"
  policies = [
    {
      name            = "tf-testacc-policy-2022"
      defined_actions = join(",", ["slb-all", "vpc-all", "vswitch-all"])
      actions         = join(",", ["vpc:AssociateEipAddress", "vpc:UnassociateEipAddress"])
      resources       = join(",", ["acs:vpc:*:*:eip/eip-12345", "acs:slb:*:*:*"])
    },
    {
      actions   = join(",", ["ecs:ModifyInstanceAttribute", "vpc:ModifyVpc", "vswitch:ModifyVSwitch"])
      resources = join(",", ["acs:ecs:*:*:instance/i-001", "acs:vpc:*:*:vpc/v-001", "acs:vpc:*:*:vswitch/vsw-001"])
      effect    = "Deny"
    }
  ]
}