
output "users_id" {
  description = "The users created"
  value       = [for value in alicloud_ram_user.this : value]
}

output "access_keys" {
  description = "The access keys created"
  value       = [for value in alicloud_ram_access_key.this : value]
}

output "secret_keys" {
  description = "The secret keys created"
  value       = [for value in fileset(path.cwd, "*.key") : file(value)]
}

output "user_system_policy_attachments" {
  description = "The System policies attached to the users"
  value       = [for value in alicloud_ram_user_policy_attachment.system_policies : value]
}

output "user_custom_policy_attachments" {
  description = "The Custom policies attached to the users"
  value       = [for value in alicloud_ram_user_policy_attachment.custom_policies : value]
}