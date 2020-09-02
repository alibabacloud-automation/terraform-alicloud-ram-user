module "ram-user" {
  source = "../.."

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
