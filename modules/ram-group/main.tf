resource "random_uuid" "this" {
}

locals {
  create        = var.existing_group_name != null ? false : var.create
  attach_policy = var.existing_group_name != null || var.create ? true : false
  group_name    = var.group_name != null ? var.group_name : substr("ram-group-${replace(random_uuid.this.result, "-", "")}", 0, 32)
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
  this_group_name = var.existing_group_name != null ? var.existing_group_name : concat(alicloud_ram_group.this.*.name, [""])[0]
}

################################
# RAM group
################################
resource "alicloud_ram_group" "this" {
  count = local.create ? 1 : 0

  name     = local.group_name
  comments = var.comments != "" ? var.comments : null
  force    = var.force_destroy_group
}

################################
# RAM group membership
################################
resource "alicloud_ram_group_membership" "this" {
  count = local.this_group_name != "" && length(var.user_names) > 0 ? 1 : 0

  group_name = local.this_group_name
  user_names = var.user_names
}

################################
# RAM group policy attachements
################################
resource "alicloud_ram_group_policy_attachment" "this" {
  count = local.attach_policy ? length(local.policy_list) : 0

  group_name  = local.this_group_name
  policy_name = lookup(local.policy_list[count.index], "policy_name")
  policy_type = lookup(local.policy_list[count.index], "policy_type")
}

resource "alicloud_ram_group_policy_attachment" "managed_custom" {
  count = length(var.managed_custom_policy_names) > 0 ? length(var.managed_custom_policy_names) : 0

  group_name  = local.group_name
  policy_name = element(var.managed_custom_policy_names, count.index)
  policy_type = "Custom"
}

resource "alicloud_ram_group_policy_attachment" "managed_system" {
  count = length(var.managed_system_policy_names) > 0 ? length(var.managed_system_policy_names) : 0

  group_name  = local.group_name
  policy_name = element(var.managed_system_policy_names, count.index)
  policy_type = "System"
}
