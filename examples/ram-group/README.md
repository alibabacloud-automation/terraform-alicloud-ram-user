# RAM group with policies example

Configuration in this directory creates RAM group with users who has specified RAM policies.


# Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Outputs
| Name | Description |
|------|-------------|
| this_group_name | RAM group name |
| this_group_user_names | User name which has be added to group |
| this_group_policy_name | The name of policy which bind to group |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
