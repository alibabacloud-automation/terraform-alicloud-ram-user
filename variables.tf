variable "create" {
  description = "Whether to create ram user."
  type        = bool
  default     = true
}

variable "existing_user_name" {
  description = "(Deprecated) The name of an existing RAM group. If set, 'create' will be ignored."
  type        = string
  default     = null
}

variable "user_name" {
  description = "Desired name for the ram user. If not set, a default name with prefix 'ram-user-' will be returned."
  type        = string
  default     = null
}

variable "display_name" {
  description = "Name of the RAM user which for display"
  type        = string
  default     = null
}

variable "mobile" {
  description = "Phone number of the RAM user. This number must contain an international area code prefix, just look like this: 86-18600008888."
  type        = string
  default     = null
}

variable "email" {
  description = "Email of the RAM user."
  type        = string
  default     = null
}

variable "comments" {
  description = "Comment of the RAM user. This parameter can have a string of 1 to 128 characters."
  type        = string
  default     = null
}

variable "force_destroy_user" {
  description = "When destroying this user, destroy even if it has non-Terraform-managed ram access keys, login profile or MFA devices. Without force_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed."
  type        = bool
  default     = false
}

################################
# RAM login profile
################################
variable "create_ram_user_login_profile" {
  description = "Whether to create ram user login profile"
  type        = bool
  default     = false
}

variable "password" {
  description = "Login password of the user"
  type        = string
  default     = null
}

variable "password_reset_required" {
  description = "This parameter indicates whether the password needs to be reset when the user first logs in. Default value is 'false'."
  type        = bool
  default     = false
}

variable "mfa_bind_required" {
  description = "This parameter indicates whether the MFA needs to be bind when the user first logs in. Default value is 'false'."
  type        = bool
  default     = false
}

################################
# RAM access key
################################
variable "create_ram_access_key" {
  description = "Whether to create ram access key. Default value is 'false'."
  type        = bool
  default     = false
}

variable "pgp_key" {
  description = "Either a base-64 encoded PGP public key, or a keybase username in the form"
  type        = string
  default     = null
}

variable "secret_file" {
  description = "A file used to store access key and secret key of ther user."
  type        = string
  default     = null
}

variable "status" {
  description = "Status of access key"
  type        = string
  default     = "Active"
}

################################
# RAM user policy attachment
################################
variable "create_user_attachment" {
  description = "(Deprecated, works with the deprecated variable 'policies') Whether to attach RAM policy to RAM user. Default value is 'false'."
  type        = bool
  default     = false
}

variable "policies" {
  description = "(Deprecated, use 'managed_custom_policy_names' and 'managed_system_policy_names') List of the policies that binds the user. Each item can contains keys: 'policy_name'(the name of policy that used to bind the user), 'policy_type'(the type of ram policies, System or Custom, default to Custom.)."
  type        = list(map(string))
  default     = []
}

variable "managed_custom_policy_names" {
  description = "List of names of managed policies of Custom type to attach to RAM user"
  type        = list(string)
  default     = []
}

variable "managed_system_policy_names" {
  description = "List of names of managed policies of System type to attach to RAM user"
  type        = list(string)
  default     = []
}
