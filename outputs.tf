output "this_user_name" {
  description = "(Deprecated, use 'user_name') The name of RAM user"
  value       = concat(alicloud_ram_user.this.*.name, [""])[0]
}

output "this_ram_user_unique_id" {
  description = "(Deprecated, use 'user_id') The unique ID assigned by alicloud"
  value       = concat(alicloud_ram_user.this.*.id, [""])[0]
}

output "this_user_policy_name" {
  description = "(Deprecated, only works with the deprecated variable 'policies') The name of RAM policy which bind to RAM user"
  value       = concat(alicloud_ram_user_policy_attachment.this.*.policy_name, [""])[0]
}

output "user_name" {
  description = "The name of RAM user"
  value       = concat(alicloud_ram_user.this.*.name, [""])[0]
}

output "user_id" {
  description = "The unique ID assigned by alicloud"
  value       = concat(alicloud_ram_user.this.*.id, [""])[0]
}

output "access_key_id" {
  description = "The access key ID"
  value       = concat(alicloud_ram_access_key.this.*.id, alicloud_ram_access_key.no_pgp.*.id, [""])[0]
}

output "access_key_secret" {
  description = "The access key secret"
  value       = concat(alicloud_ram_access_key.this.*.secret, alicloud_ram_access_key.no_pgp.*.secret, [""])[0]
  sensitive   = true
}

output "access_key_encrypted_secret" {
  description = "The access key encrypted secret, base64 encoded"
  value       = concat(alicloud_ram_access_key.this.*.encrypted_secret, alicloud_ram_access_key.no_pgp.*.encrypted_secret, [""])[0]
}

output "access_key_key_fingerprint" {
  description = "The fingerprint of the PGP key used to encrypt the secret"
  value       = concat(alicloud_ram_access_key.this.*.key_fingerprint, alicloud_ram_access_key.no_pgp.*.key_fingerprint, [""])[0]
}

output "access_key_status" {
  description = "Active or Inactive. Keys are initially active, but can be made inactive by other means."
  value       = concat(alicloud_ram_access_key.this.*.status, alicloud_ram_access_key.no_pgp.*.status, [""])[0]
}

output "pgp_key" {
  description = "PGP key used to encrypt sensitive data for this user (if empty, no encryption)"
  value       = var.pgp_key
}
