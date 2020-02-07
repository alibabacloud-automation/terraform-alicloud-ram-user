module "ram-group-with-policies" {
  source = "../../modules/ram-group-with-policies"

  ################################
  # RAM group
  ################################
  group_name = "test-ram-group"
  comments   = "this is a test ram group"

  ################################
  # RAM group membership
  ################################
  # before joining the RAM group, make sure the RAM user has been created.
  user_names = ["user1", "user2"]

  ################################
  # RAM group policy attachements
  ################################
  create_group_attachment = true
  policies = [
    # Binding a system policy.
    {
      policy_names = join(",", ["AliyunVPCFullAccess", "AliyunKafkaFullAccess"])
      policy_type  = "System"
    },
    # When binding custom policy, make sure this policy has been created.
    {
      policy_names = "VpcListTagResources,RamPolicyForZhangsan"
      policy_type  = "Custom"
    },
    # Create policy and bind the ram group.
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