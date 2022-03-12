################################
# RAM user
################################
variable "display_name" {
  description = "Name of the RAM user which for display"
  type        = string
  default     = "tf-testacc-display-name"
}

variable "mobile" {
  description = "Phone number of the RAM user. This number must contain an international area code prefix, just look like this: 86-18600008888."
  type        = string
  default     = "18666666666"
}

variable "email" {
  description = "Email of the RAM user."
  type        = string
  default     = "168@gmail.com"
}

variable "comments" {
  description = "Comment of the RAM user. This parameter can have a string of 1 to 128 characters."
  type        = string
  default     = "tf-testacc-comments"
}

variable "force_destroy_user" {
  description = "When destroying this user, destroy even if it has non-Terraform-managed ram access keys, login profile or MFA devices. Without force_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed."
  type        = bool
  default     = false
}

################################
# RAM login profile
################################
variable "password" {
  description = "Login password of the user"
  type        = string
  default     = "YourPassword123!"
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