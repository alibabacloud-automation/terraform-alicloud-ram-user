locals {
  resource_name_prefix = "tfmod-ram-user-complete"
  policy_name = "${local.resource_name_prefix}-custom-policy-1"
}

resource "alicloud_ram_policy" "custom-policy-1" {
  policy_name     = local.policy_name
  policy_document = <<EOF
	{
		"Version": "1",
		"Statement": [
		  {
			"Action": "ecs:*",
			"Resource": "*",
			"Effect": "Allow"
		  }
		]
	  }
	EOF
}

module "ram_user" {
  source = "../.."

  # RAM user
  create = true

  user_name          = "${local.resource_name_prefix}-user-2022"
  display_name       = var.display_name
  mobile             = var.mobile
  email              = var.email
  comments           = var.comments
  force_destroy_user = var.force_destroy_user

  # RAM login profile
  create_ram_user_login_profile = false

  # RAM access key
  create_ram_access_key = false

  # RAM user policy attachment
  create_user_attachment = false

}

module "ram_login_profile" {
  source = "../.."

  # RAM user
  create = false

  # RAM login profile
  create_ram_user_login_profile = true

  existing_user_name      = module.ram_user.user_name
  password                = var.password
  password_reset_required = var.password_reset_required
  mfa_bind_required       = var.mfa_bind_required

  # RAM access key
  create_ram_access_key = false

  # RAM user policy attachment
  create_user_attachment = false

}

module "ram_access_key" {
  source = "../.."

  # RAM user
  create = false

  # RAM login profile
  create_ram_user_login_profile = false

  # RAM access key
  create_ram_access_key = true

  existing_user_name = module.ram_user.user_name
  secret_file        = "secret.txt"

  # RAM user policy attachment
  create_user_attachment = false

}

module "ram_user_policy_attachment" {
  source = "../.."

  # RAM user
  create = false

  # RAM login profile
  create_ram_user_login_profile = false

  # RAM access key
  create_ram_access_key = false

  # RAM user policy attachment
  create_user_attachment = true

  existing_user_name = module.ram_user.user_name
  policies = [
    {
      policy_names = local.policy_name
      policy_type  = "Custom"
    }
  ]
}

module "ram_group" {
  source = "../../modules/ram-group"

  # RAM group
  create = true

  group_name          = "${local.resource_name_prefix}-group"
  comments            = var.comments
  force_destroy_group = var.force_destroy_user

}

module "ram_group_membership" {
  source = "../../modules/ram-group"

  # RAM group
  create = false

  # RAM group membership
  existing_group_name = module.ram_group.group_name
  user_names          = [module.ram_user.user_name]

}

module "ram_group_policy_attachment" {
  source = "../../modules/ram-group"

  # RAM group
  create = false

  # RAM group policy attachements
  existing_group_name = module.ram_group.group_name
  policies = [
    {
      policy_names = local.policy_name
      policy_type  = "Custom"
    }
  ]
}
