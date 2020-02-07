# RAM user example

Configuration in this directory creates RAM user with specified password, a pair of access key and access secret, which will be stored in './secret.txt'. This user can be attached with ram policies.

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
| this_ram_user_name | The user's name |
| this_ram_user_unique_id | The unique ID assigned by Alibaba Cloud |
| this_user_policy_name | The name of RAM policy which bind to RAM user |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
