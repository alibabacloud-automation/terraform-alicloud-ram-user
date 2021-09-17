################################
# RAM user
################################
variable "user_name" {
  description = "Desired name for the ram user. If not set, a default name with prefix 'ram-user-' will be returned."
  type        = string
  default     = "test-user-1990"
}

variable "mobile" {
  description = "Phone number of the RAM user. This number must contain an international area code prefix, just look like this: 86-18600008888."
  type        = string
  default     = "86-18688888888"
}

variable "user_display_name" {
  description = "Name of the RAM user which for display."
  type        = string
  default     = "user_display_name_test"
}

variable "email" {
  description = "Email of the RAM user."
  type        = string
  default     = "13366668888@163.com"
}

variable "comments" {
  description = "Comment of the RAM user. This parameter can have a string of 1 to 128 characters."
  type        = string
  default     = "this is a test user"
}

variable "force_destroy_user" {
  description = "When destroying this user, destroy even if it has non-Terraform-managed ram access keys, login profile or MFA devices. Without force_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed."
  type        = bool
  default     = false
}

variable "password" {
  description = "Login password of the user"
  type        = string
  default     = "Yourpassword_1234"
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

variable "secret_file" {
  description = "A file used to store access key and secret key of ther user."
  type        = string
  default     = "secret.pem"
}
