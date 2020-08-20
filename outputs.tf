
output "users_id" {
  description = "Map of vswitch ids"
  value       = [for value in alicloud_ram_user.this : value]
}

output "access_keys" {
  description = "Map of vswitch ids"
  value       = [for value in alicloud_ram_access_key.this : value]
}

output "secret_keys" {
  description = "Map of vswitch ids"
  value       = [for value in alicloud_ram_access_key.this : file(value.secret_file)]
}

/*
output "this_user_name" {
  description = "The name of RAM user"
  value       = alicloud_ram_user.this.*.name
}

output "this_ram_user_unique_id" {
  description = "The unique ID assigned by alicloud"
  value       = alicloud_ram_user.this.*.id
}

output "this_user_policy_name" {
  description = "The name of RAM policy which bind to RAM user"
  value       = alicloud_ram_user_policy_attachment.this.*.policy_name
}
*/