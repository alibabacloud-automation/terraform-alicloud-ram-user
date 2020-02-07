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
# RAM group
################################
variable "existing_group_name" {
  description = "The name of an existing RAM group. If set, 'create' will be ignored."
  type        = string
  default     = ""
}

variable "group_name" {
  description = "Name of the RAM group. If not set, a default name with prefix 'ram-group-' will be returned."
  type        = string
  default     = ""
}

variable "create" {
  description = "Whether to create RAM group."
  type        = bool
  default     = true
}

variable "force_destroy_group" {
  description = "This parameter is used for resource destroy."
  type        = bool
  default     = false
}

variable "comments" {
  description = "Comment of the RAM group. This parameter can have a string of 1 to 128 characters."
  type        = string
  default     = ""
}

################################
# RAM group membership
################################
variable "user_names" {
  description = "Set of user name which will be added to group"
  type        = set(string)
}

################################
# RAM group policy attachements
################################
variable "create_group_attachment" {
  description = "Whether to attach RAM policy to RAM group"
  type        = bool
  default     = false
}

variable "policies" {
  description = "List of the policies that binds the role. Each item can contains keys: 'policy_name'(the name of policy that used to bind the role), 'policy_type'(the type of ram policies, System or Custom, default to Custom.)."
  type        = list(map(string))
  default     = []
}