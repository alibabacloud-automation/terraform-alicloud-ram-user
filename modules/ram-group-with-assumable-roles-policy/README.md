# ram-group-with-assumable-roles-policy

## Usage

Create RAM groups with users who are allowed to assume RAM roles.

```hcl
# Prepare a RAM user
resource "alicloud_ram_user" "test-ram-user" {
  name = "test-ram-user"
}

# Prepare a RAM assumable role
resource "alicloud_ram_role" "test-ram-role" {
  name        = "test-ram-role"
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

# Create a ram group with test-ram-user which is allowed to assume test-ram-role.
module "ram-group-with-assumable-roles-policy-example" {
  source  = "terraform-alicloud-modules/ram/alicloud//modules/ram-group-with-assumable-roles-policy"

  group_name  = "test-ram-group-example"

  assumable_roles = [
    alicloud_ram_role.test-ram-role.arn
  ]

  user_names = [
    alicloud_ram_user.test-ram-user.name
  ]
}

```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_ram_group.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_group) | resource |
| [alicloud_ram_group_membership.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_group_membership) | resource |
| [alicloud_ram_group_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_group_policy_attachment) | resource |
| [alicloud_ram_policy.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/ram_policy) | resource |
| [random_uuid.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_action"></a> [action](#input\_action) | Operations on specific resources | `string` | `"sts:AssumeRole"` | no |
| <a name="input_assumable_roles"></a> [assumable\_roles](#input\_assumable\_roles) | List of RAM roles ARNs which can be assumed by the group | `list(string)` | `[]` | no |
| <a name="input_force"></a> [force](#input\_force) | This parameter is used for resource destroy | `bool` | `false` | no |
| <a name="input_group_name"></a> [group\_name](#input\_group\_name) | Name of RAM group. If not set, a default name with prefix `group-assumable-roles-` will be returned. | `string` | `null` | no |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | Name of RAM policy, If not set, a default name with prefix `assumable-roles-policy-` will be returned. | `string` | `null` | no |
| <a name="input_user_names"></a> [user\_names](#input\_user\_names) | List of RAM users to have in an RAM group which can assume the role | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_assumable_roles"></a> [assumable\_roles](#output\_assumable\_roles) | List of ARNs of RAM roles which members of RAM group can assume |
| <a name="output_group_name"></a> [group\_name](#output\_group\_name) | RAM group name |
| <a name="output_group_users"></a> [group\_users](#output\_group\_users) | List of RAM users in RAM group |
| <a name="output_policy_name"></a> [policy\_name](#output\_policy\_name) | Assume role policy ARN of RAM group |
<!-- END_TF_DOCS -->
