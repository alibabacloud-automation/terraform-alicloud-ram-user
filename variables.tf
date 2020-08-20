variable "region" {
  description = "The region used to launch this module resources."
  type        = string
  default     = ""
}

variable "profile" {
  description = "The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable."
  type        = string
  default     = ""
}
variable "shared_credentials_file" {
  description = "This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used."
  type        = string
  default     = ""
}

variable "skip_region_validation" {
  description = "Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet)."
  type        = bool
  default     = false
}

################################
# RAM user
################################

variable "users" {
  description = "Create RAM users"
  type        = list(object({ name = string, display_name = string, mobile = string, email = string, comments = string }))
  default     = []
}

variable "force_destroy_user" {
  description = "When destroying this user, destroy even if it has non-Terraform-managed ram access keys, login profile or MFA devices. Without force_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed."
  type        = bool
  default     = false
}

################################
# RAM login profile
################################
# TODO evaluate an improvement to add a submodule for RAM login profiles in case there is the preference to have default values
# password => The Console password to access
# password_reset_required => This parameter indicates whether the password needs to be reset when the user first logs in. Default value is 'false'
# mfa_bind_required => This parameter indicates whether the MFA needs to be bind when the user first logs in. Default value is 'false'.

variable "login_profiles" {
  description = "Create login profiles for the RAM users"
  type        = list(object({ user_name = string, password = string, password_reset_required = bool, mfa_bind_required = bool }))
  default     = []
}


################################
# RAM access key
################################

variable "access_keys" {
  description = "Create access keys for the RAM users"
  type        = list(string)
  default     = []
}

/*

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
*/