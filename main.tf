provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/ram-user"
}

resource "random_uuid" "this" {}

/*
locals {
  create         = var.existing_user_name != "" ? false : var.create
  create_profile = var.existing_user_name != "" || var.create ? true : false
  attach_policy  = var.existing_user_name != "" || var.create ? true : false
  user_name      = var.user_name != "" ? var.user_name : substr("ram-user-${replace(random_uuid.this.result, "-", "")}", 0, 32)
  policy_list = flatten(
    [
      for _, obj in var.policies : [
        for _, name in distinct(flatten(split(",", obj["policy_names"]))) : {
          policy_name = name
          policy_type = lookup(obj, "policy_type", "Custom")
        }
      ]
    ]
  )
  this_user_name = var.existing_user_name != "" ? var.existing_user_name : concat(alicloud_ram_user.this.*.name, [""])[0]

}
*/

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
  for_each =  toset(var.access_keys)
  user_name   = each.value
  secret_file = "${each.value}.key"
}



/*



################################
# RAM user policy attachment
################################
resource "alicloud_ram_user_policy_attachment" "this" {
  count = local.attach_policy ? length(local.policy_list) : 0

  user_name   = local.this_user_name
  policy_name = lookup(local.policy_list[count.index], "policy_name")
  policy_type = lookup(local.policy_list[count.index], "policy_type")
}

*/