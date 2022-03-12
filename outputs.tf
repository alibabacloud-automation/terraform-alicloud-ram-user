output "this_user_name" {
  description = "The name of RAM user"
  value       = concat(alicloud_ram_user.this.*.name, [""])[0]
}

output "this_ram_user_unique_id" {
  description = "The unique ID assigned by alicloud"
  value       = concat(alicloud_ram_user.this.*.id, [""])[0]
}

output "this_user_policy_name" {
  description = "The name of RAM policy which bind to RAM user"
  value       = concat(alicloud_ram_user_policy_attachment.this.*.policy_name, [""])[0]
}