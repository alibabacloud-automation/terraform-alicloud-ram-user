module "ram_policy" {
  source = "terraform-alicloud-modules/ram-policy/alicloud"
  policies = [
    {
      name            = "manage-slb-and-eip-resources-test004"
      defined_actions = join(",", ["slb-all", "vpc-all", "vswitch-all"])
      actions         = join(",", ["vpc:AssociateEipAddress", "vpc:UnassociateEipAddress"])
      resources       = join(",", ["acs:vpc:*:*:eip/eip-12345", "acs:slb:*:*:*"])
    },
    {
      #actions is the action of custom specific resource.
      #resources is the specific object authorized to customize.
      name            = "manage-instance-resource-test004"
      actions   = join(",", ["ecs:ModifyInstanceAttribute", "vpc:ModifyVpc", "vswitch:ModifyVSwitch"])
      resources = join(",", ["acs:ecs:*:*:instance/i-001", "acs:vpc:*:*:vpc/v-001", "acs:vpc:*:*:vswitch/vsw-001"])
      effect    = "Deny"
    }
  ]
}

module "ram-user" {
  source = "../.."
  ################################
  # RAM user
  ################################
  create                        = true
  create_ram_user_login_profile = false
  create_ram_access_key         = false
  display_name                  = var.user_display_name
  user_name                     = var.user_name
  mobile                        = var.mobile
  email                         = var.email
  comments                      = var.comments
  force_destroy_user            = var.force_destroy_user
}

module "ram-user1" {
  source = "../.."
  create                        = false
  create_ram_user_login_profile = true
  create_ram_access_key         = false
  ################################
  # RAM login profile
  ################################
  existing_user_name            = module.ram-user.this_user_name
  password                      = var.password
  password_reset_required       = var.password_reset_required
  mfa_bind_required             = var.mfa_bind_required
}

module "ram-user2" {
  source = "../.."
  create                        = false
  create_ram_user_login_profile = false
  create_ram_access_key         = true
  ################################
  # RAM access key
  ################################
  secret_file                   = var.secret_file
  existing_user_name            = module.ram-user.this_user_name
}

module "ram-user3" {
  source = "../.."
  create                        = false
  create_ram_user_login_profile = false
  create_ram_access_key         = false
  ################################
  # RAM access key
  ################################
  existing_user_name            = module.ram-user.this_user_name
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