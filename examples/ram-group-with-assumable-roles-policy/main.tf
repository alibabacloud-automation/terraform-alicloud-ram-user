locals {
  resource_name_prefix = "tfmod-ram-user-ram-group-with-assumable"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

#########################
# Prepare 2 RAM users
#########################
resource "alicloud_ram_user" "prepared-user-1" {
  name = "${local.resource_name_prefix}-${random_integer.default.result}-prepared-user-1"
}

resource "alicloud_ram_user" "prepared-user-2" {
  name = "${local.resource_name_prefix}-${random_integer.default.result}-prepared-user-2"
}

######################################
# Prepare several ram assumable roles
######################################
resource "alicloud_ram_role" "prepared-role" {
  name        = "${local.resource_name_prefix}-${random_integer.default.result}-prepared-role"
  description = "${local.resource_name_prefix}-${random_integer.default.result}-prepared-role"
  document    = <<EOF
  {
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
          "Service": [
            "apigateway.aliyuncs.com",
            "ecs.aliyuncs.com"
          ]
        }
      }
    ],
    "Version": "1"
  }
  EOF
}

#################################################################
# Create a ram group where user1 and user2 are allowed to assume
# the prepared roles.
#################################################################
module "example" {
  source = "../../modules/ram-group-with-assumable-roles-policy"

  group_name  = "${local.resource_name_prefix}-${random_integer.default.result}-example"
  policy_name = "AliyunOSSFullAccess"

  assumable_roles = [
    alicloud_ram_role.prepared-role.arn,
  ]

  user_names = [
    alicloud_ram_user.prepared-user-1.name,
    alicloud_ram_user.prepared-user-2.name,
  ]
}
