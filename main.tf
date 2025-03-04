resource "random_uuid" "this" {
}

locals {
  user_name = var.user_name != null ? var.user_name : substr("ram-user-${replace(random_uuid.this.result, "-", "")}", 0, 32)
}

################################
# RAM user
################################
resource "alicloud_ram_user" "this" {
  count        = var.create ? 1 : 0
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

  user_name               = alicloud_ram_user.this[0].name
  password                = var.password
  password_reset_required = var.password_reset_required
  mfa_bind_required       = var.mfa_bind_required
}

################################
# RAM access key
################################
resource "alicloud_ram_access_key" "this" {
  count = var.create && var.create_ram_access_key && var.pgp_key != null ? 1 : 0

  user_name   = alicloud_ram_user.this[0].name
  secret_file = var.secret_file
  status      = var.status
  pgp_key     = var.pgp_key
}

resource "alicloud_ram_access_key" "no_pgp" {
  count = var.create && var.create_ram_access_key && var.pgp_key == null ? 1 : 0

  user_name   = alicloud_ram_user.this[0].name
  secret_file = var.secret_file
  status      = var.status
}

################################
# RAM user policy attachment
################################
resource "alicloud_ram_user_policy_attachment" "custom" {
  for_each = { for idx, name in var.managed_custom_policy_names : name => name }

  user_name   = alicloud_ram_user.this[0].name
  policy_name = each.key
  policy_type = "Custom"
}

resource "alicloud_ram_user_policy_attachment" "system" {
  for_each = { for idx, name in var.managed_system_policy_names : name => name }

  user_name   = alicloud_ram_user.this[0].name
  policy_name = each.key
  policy_type = "System"
}
