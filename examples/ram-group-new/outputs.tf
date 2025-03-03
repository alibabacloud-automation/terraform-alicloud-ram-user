output "group_name" {
  description = "The name of group"
  value       = module.example.group_name
}

output "group_user_names" {
  description = "User name which has be added to group"
  value       = module.example.group_user_names
}
