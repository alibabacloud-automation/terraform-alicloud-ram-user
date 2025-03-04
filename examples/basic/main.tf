locals {
  resource_name_prefix = "tfmod-ram-user-basic"
}

resource "random_integer" "default" {
  min = 0
  max = 99999
}

module "example" {
  source = "../.."

  user_name                     = "${local.resource_name_prefix}-${random_integer.default.result}-example"
  create_ram_user_login_profile = false
  create_ram_access_key         = true
  managed_system_policy_names   = ["AliyunECSReadOnlyAccess", "AliyunRAMReadOnlyAccess"]
}
