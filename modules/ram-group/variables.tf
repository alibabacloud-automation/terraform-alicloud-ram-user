variable "create" {
  description = "Whether to create RAM group."
  type        = bool
  default     = true
}

variable "existing_group_name" {
  description = "(Deprecated) The name of an existing RAM group. If set, 'create' will be ignored."
  type        = string
  default     = null
}

variable "group_name" {
  description = "Name of the RAM group. If not set, a default name with prefix 'ram-group-' will be returned."
  type        = string
  default     = null
}

variable "comments" {
  description = "Comment of the RAM group. This parameter can have a string of 1 to 128 characters."
  type        = string
  default     = "this group was created by terrafom module ram-user/modules/ram-group."
}

variable "force_destroy_group" {
  description = "This parameter is used for resource destroy."
  type        = bool
  default     = false
}

################################
# RAM group membership
################################
variable "user_names" {
  description = "List of user name which will be added to group"
  type        = list(string)
  default     = []
}

################################
# RAM group policy attachements
################################
variable "policies" {
  description = "(Deprecated, use 'managed_custom_policy_names' and 'managed_system_policy_names') List of the policies that binds the role. Each item can contains keys: 'policy_name'(the name of policy that used to bind the role), 'policy_type'(the type of ram policies, System or Custom, default to Custom.)."
  type        = list(map(string))
  default     = []
}

variable "managed_custom_policy_names" {
  description = "List of names of managed policies of Custom type to attach to RAM group"
  type        = list(string)
  default     = []
}

variable "managed_system_policy_names" {
  description = "List of names of managed policies of System type to attach to RAM group"
  type        = list(string)
  default     = []
}
