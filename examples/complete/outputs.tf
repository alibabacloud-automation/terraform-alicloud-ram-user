output "this_user_name" {
  description = "The name of RAM user"
  value       = module.ram_user.this_user_name
}

output "this_ram_user_unique_id" {
  description = "The unique ID assigned by alicloud"
  value       = module.ram_user.this_ram_user_unique_id
}

output "this_user_policy_name" {
  description = "The name of RAM policy which bind to RAM user"
  value       = module.ram_user_policy_attachment.this_user_policy_name
}

output "this_group_name" {
  description = "The name of group"
  value       = module.ram_group.this_group_name
}

output "this_group_user_names" {
  description = "user name which has be added to group"
  value       = module.ram_group_membership.this_group_user_names
}

output "this_group_policy_name" {
  description = "The name of policy which bind to group"
  value       = module.ram_group_policy_attachment.this_group_policy_name
}