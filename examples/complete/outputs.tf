output "user_name" {
  description = "The name of RAM user"
  value       = module.ram_user.user_name
}

output "user_id" {
  description = "The unique ID assigned by alicloud"
  value       = module.ram_user.user_id
}

output "this_user_policy_name" {
  description = "(Deprecated, only works with the deprecated variable 'policies') The name of RAM policy which bind to RAM user"
  value       = module.ram_user_policy_attachment.this_user_policy_name
}

output "this_group_policy_name" {
  description = "(Deprecated, works with the deprecated variable 'policies') The name of policy which bind to group"
  value       = module.ram_group_policy_attachment.this_group_policy_name
}

output "group_name" {
  description = "The name of group"
  value       = module.ram_group.group_name
}

output "group_user_names" {
  description = "user name which has be added to group"
  value       = module.ram_group_membership.group_user_names
}
