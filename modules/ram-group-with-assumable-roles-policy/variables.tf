variable "policy_name" {
  description = "Name of RAM policy, If not set, a default name with prefix `assumable-roles-policy-` will be returned. "
  type        = string
  default     = null
}

variable "action" {
  description = "Operations on specific resources"
  type        = string
  default     = "sts:AssumeRole"
}

variable "assumable_roles" {
  description = "List of RAM roles ARNs which can be assumed by the group"
  type        = list(string)
  default     = []
}

variable "force" {
  description = "This parameter is used for resource destroy"
  type        = bool
  default     = false
}

variable "group_name" {
  description = "Name of RAM group. If not set, a default name with prefix `group-assumable-roles-` will be returned."
  type        = string
  default     = null
}

variable "user_names" {
  description = "List of RAM users to have in an RAM group which can assume the role"
  type        = list(string)
  default     = []
}
