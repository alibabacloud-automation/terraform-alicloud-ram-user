variable "region" {
  description = "(Deprecated from version 1.1.0) The region used to launch this module resources."
  type        = string
  default     = ""
}

variable "profile" {
  description = "(Deprecated from version 1.1.0) The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable."
  type        = string
  default     = ""
}
variable "shared_credentials_file" {
  description = "(Deprecated from version 1.1.0) This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used."
  type        = string
  default     = ""
}

variable "skip_region_validation" {
  description = "(Deprecated from version 1.1.0) Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet)."
  type        = bool
  default     = false
}

################################
# RAM user
################################
variable "create" {
  description = "Whether to create ram user."
  type        = bool
  default     = true
}

variable "existing_user_name" {
  description = "The name of an existing RAM group. If set, 'create' will be ignored."
  type        = string
  default     = ""
}

variable "user_name" {
  description = "Desired name for the ram user. If not set, a default name with prefix 'ram-user-' will be returned."
  type        = string
  default     = ""
}

variable "display_name" {
  description = "Name of the RAM user which for display"
  type        = string
  default     = ""
}

variable "mobile" {
  description = "Phone number of the RAM user. This number must contain an international area code prefix, just look like this: 86-18600008888."
  type        = string
  default     = ""
}

variable "email" {
  description = "Email of the RAM user."
  type        = string
  default     = ""
}

variable "comments" {
  description = "Comment of the RAM user. This parameter can have a string of 1 to 128 characters."
  type        = string
  default     = ""
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
  default     = ""
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

variable "secret_file" {
  description = "A file used to store access key and secret key of ther user."
  type        = string
  default     = ""
}

################################
# RAM user policy attachment
################################
variable "create_user_attachment" {
  description = "Whether to attach RAM policy to RAM user. Default value is 'false'."
  type        = bool
  default     = false
}

variable "policies" {
  description = "List of the policies that binds the role. Each item can contains keys: 'policy_name'(the name of policy that used to bind the role), 'policy_type'(the type of ram policies, System or Custom, default to Custom.)."
  type        = list(map(string))
  default     = []
}