module "ram-user" {
  source = "../.."

  ################################
  # RAM user
  ################################
  user_name = "test-user"
  mobile    = "86-18688888888"
  email     = "13366668888@163.com"
  comments  = "this is a test user"

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
