resource "random_uuid" "this" {
}

locals {
  create         = var.existing_user_name != null ? false : var.create
  user_name      = var.user_name != null ? var.user_name : substr("ram-user-${replace(random_uuid.this.result, "-", "")}", 0, 32)
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
  this_user_name = var.existing_user_name != null ? var.existing_user_name : concat(alicloud_ram_user.this.*.name, [""])[0]
}

################################
# RAM user
################################
resource "alicloud_ram_user" "this" {
  count        = local.create ? 1 : 0
  name         = local.user_name
  display_name = var.display_name
  mobile       = var.mobile
  email        = var.email
  comments     = var.comments
  force        = var.force_destroy_user
}

################################
# RAM login profile
################################
resource "alicloud_ram_login_profile" "this" {
  count = var.create_ram_user_login_profile ? 1 : 0

  user_name               = local.this_user_name
  password                = var.password
  password_reset_required = var.password_reset_required
  mfa_bind_required       = var.mfa_bind_required
}

################################
# RAM access key
################################
resource "alicloud_ram_access_key" "this" {
  count = local.create && var.create_ram_access_key && var.pgp_key != null ? 1 : 0

  user_name   = local.this_user_name
  secret_file = var.secret_file
  status      = var.status
  pgp_key     = var.pgp_key
}

resource "alicloud_ram_access_key" "no_pgp" {
  count = local.create && var.create_ram_access_key && var.pgp_key == null ? 1 : 0

  user_name   = local.this_user_name
  secret_file = var.secret_file
  status      = var.status
}

################################
# RAM user policy attachment
################################
resource "alicloud_ram_user_policy_attachment" "this" {
  count = var.create_user_attachment ? length(local.policy_list) : 0

  user_name   = local.this_user_name
  policy_name = lookup(local.policy_list[count.index], "policy_name")
  policy_type = lookup(local.policy_list[count.index], "policy_type")
}

resource "alicloud_ram_user_policy_attachment" "custom" {
  for_each = { for k, v in var.managed_custom_policy_names : k => v if local.create }

  user_name   = alicloud_ram_user.this[0].name
  policy_name = each.value
  policy_type = "Custom"
}

resource "alicloud_ram_user_policy_attachment" "system" {
  for_each = { for k, v in var.managed_system_policy_names : k => v if local.create }

  user_name   = alicloud_ram_user.this[0].name
  policy_name = each.value
  policy_type = "System"
}
