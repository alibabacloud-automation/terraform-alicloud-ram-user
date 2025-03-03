resource "random_uuid" "this" {
}

locals {
  group_name = var.group_name != null ? var.group_name : substr("ram-group-${replace(random_uuid.this.result, "-", "")}", 0, 32)
}

################################
# RAM group
################################
resource "alicloud_ram_group" "this" {
  count = var.create ? 1 : 0

  name     = local.group_name
  comments = var.comments != "" ? var.comments : null
  force    = var.force_destroy_group
}

################################
# RAM group membership
################################
resource "alicloud_ram_group_membership" "this" {
  count = length(var.user_names) > 0 ? 1 : 0

  group_name = alicloud_ram_group.this[0].name
  user_names = var.user_names
}

################################
# RAM group policy attachements
################################
resource "alicloud_ram_group_policy_attachment" "managed_custom" {
  for_each = { for idx, name in var.managed_custom_policy_names : name => name }

  group_name  = alicloud_ram_group.this[0].name
  policy_name = each.key
  policy_type = "Custom"
}

resource "alicloud_ram_group_policy_attachment" "managed_system" {
  for_each = { for idx, name in var.managed_system_policy_names : name => name }

  group_name  = alicloud_ram_group.this[0].name
  policy_name = each.key
  policy_type = "System"
}
