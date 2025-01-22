locals {
  resource_name_prefix = "tfmod-ram-user-basic"
}

module "example" {
  source = "../.."

  user_name                     = "${local.resource_name_prefix}-example"
  create_ram_user_login_profile = false
  create_ram_access_key         = true
  managed_system_policy_names   = ["AliyunECSReadOnlyAccess", "AliyunRAMReadOnlyAccess"]
}
