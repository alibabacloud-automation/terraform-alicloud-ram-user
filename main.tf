provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/ram-user"
}

resource "random_uuid" "this" {}

locals {

  /*
  * Alibaba alicloud_ram_user_policy_attachment supports only one value for "user_name", we need to build a cartesian product to associate each
  * managed policy to each user.
  * The alicloud_ram_user_policy_attachment does a distinction between System and Custom policies
  */

  system_policies_binding = [
    for v in setproduct(var.system_policies, [for value in alicloud_ram_user.this : value.name]) : {
      ram_policy   = v[0]
      ram_username = v[1]
    }
  ]

  custom_policies_binding = [
    for v in setproduct(var.custom_policies, [for value in alicloud_ram_user.this : value.name]) : {
      ram_policy   = v[0]
      ram_username = v[1]
    }
  ]


}


################################
# RAM user
################################

resource "alicloud_ram_user" "this" {
  for_each = {
    for user in var.users : "${user.name}" => user
  }

  name         = each.value.name != "" ? each.value.name : substr("ram-user-${replace(random_uuid.this.result, "-", "")}", 0, 32)
  display_name = each.value.display_name != "" ? each.value.display_name : null
  mobile       = each.value.mobile != "" ? each.value.mobile : null
  email        = each.value.email != "" ? each.value.email : null
  comments     = each.value.comments != "" ? each.value.comments : null
  force        = var.force_destroy_user
}

################################
# RAM login profile
################################
resource "alicloud_ram_login_profile" "this" {

  for_each = {
    for login_profile in var.login_profiles : "${login_profile.user_name}" => login_profile
  }

  user_name               = each.value.user_name
  password                = each.value.password
  password_reset_required = each.value.password_reset_required
  mfa_bind_required       = each.value.mfa_bind_required
}

################################
# RAM access key
################################
resource "alicloud_ram_access_key" "this" {
  for_each    = toset(var.access_keys)
  user_name   = each.value
  secret_file = "${each.value}.key"
}

################################
# RAM user policy attachment
################################
resource "alicloud_ram_user_policy_attachment" "system" {

  for_each = {
    for binding in local.system_policies_binding : "${binding.ram_policy}-${binding.ram_username}" => binding
  }

  policy_name = each.value.ram_policy
  policy_type = "System"
  user_name   = each.value.ram_username

}

resource "alicloud_ram_user_policy_attachment" "custom" {

  for_each = {
    for binding in local.custom_policies_binding : "${binding.ram_policy}-${binding.ram_username}" => binding
  }

  policy_name = each.value.ram_policy
  policy_type = "Custom"
  user_name   = each.value.ram_username

}