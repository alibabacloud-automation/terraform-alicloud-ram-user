output "group_users" {
  description = "List of RAM users in RAM group"
  value       = module.example.group_users
}

output "assumable_roles" {
  description = "List of ARNs of RAM roles which members of RAM group can assume"
  value       = module.example.assumable_roles
}

output "policy_name" {
  description = "Assume role policy ARN of RAM group"
  value       = module.example.policy_name
}

output "group_name" {
  description = "RAM group name"
  value       = module.example.group_name
}
