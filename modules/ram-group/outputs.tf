output "this_group_name" {
  description = "(Deprecated, use 'group_name') The name of group"
  value       = alicloud_ram_group.this.*.name
}

output "this_group_user_names" {
  description = "(Deprecated, use 'group_user_names') user name which has be added to group"
  value       = alicloud_ram_group_membership.this.*.user_names
}

output "this_group_policy_name" {
  description = "(Deprecated, works with the deprecated variable 'policies') The name of policy which bind to group"
  value       = alicloud_ram_group_policy_attachment.this.*.policy_name
}

output "group_name" {
  description = "The name of group"
  value       = concat(alicloud_ram_group.this.*.name, [""])[0]
}

output "group_user_names" {
  description = "user name which has be added to group"
  value       = concat(alicloud_ram_group_membership.this.*.user_names, [""])[0]
}
