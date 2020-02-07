provider "alicloud" {
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/ram-user"
}

resource "random_uuid" "this" {}

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

################################
# RAM user
################################
resource "alicloud_ram_user" "this" {
  count        = local.create ? 1 : 0
  name         = local.user_name
  display_name = var.display_name != "" ? var.display_name : null
  mobile       = var.mobile != "" ? var.mobile : null
  email        = var.email != "" ? var.email : null
  comments     = var.comments != "" ? var.comments : null
  force        = var.force_destroy_user
}

################################
# RAM login profile
################################
resource "alicloud_ram_login_profile" "this" {
  count = local.create_profile && var.create_ram_user_login_profile ? 1 : 0

  user_name               = local.this_user_name
  password                = var.password
  password_reset_required = var.password_reset_required
  mfa_bind_required       = var.mfa_bind_required
}

################################
# RAM access key
################################
resource "alicloud_ram_access_key" "this" {
  count = local.create_profile && var.create_ram_access_key ? 1 : 0

  user_name   = local.this_user_name
  secret_file = var.secret_file
}

################################
# RAM user policy attachment
################################
resource "alicloud_ram_user_policy_attachment" "this" {
  count = local.attach_policy ? length(local.policy_list) : 0

  user_name   = local.this_user_name
  policy_name = lookup(local.policy_list[count.index], "policy_name")
  policy_type = lookup(local.policy_list[count.index], "policy_type")
}

