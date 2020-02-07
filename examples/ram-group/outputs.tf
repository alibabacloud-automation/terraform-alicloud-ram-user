output "this_group_name" {
  description = "The name of group"
  value       = module.ram-group.this_group_name
}

output "this_group_user_names" {
  description = "User name which has be added to group"
  value       = module.ram-group.this_group_user_names
}

output "this_group_policy_name" {
  description = "The name of policy which bind to group"
  value       = module.ram-group.this_group_policy_name
}