output "this_user_name" {
  description = "The name of RAM user"
  value       = module.ram-user.this_user_name
}

output "this_ram_user_unique_id" {
  description = "The unique ID assigned by alicloud"
  value       = module.ram-user.this_ram_user_unique_id
}

output "this_user_policy_name" {
  description = "The name of RAM policy which bind to RAM user"
  value       = module.ram-user.this_user_policy_name
}



