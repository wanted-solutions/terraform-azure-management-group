# terraform-module-azure-management-group

Repository template for Azure Management Group Terraform module.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.113.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=3.113.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_management_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group_subscription_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_subscription_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | A friendly name for this Management Group. If not specified, this will be the same as the "name" variable. | `string` | `""` | no |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | Metadata object TBA | <pre>object({<br>    default_error_message = optional(string, local.metadata.default_error_message)<br>    default_validator     = optional(string, local.metadata.default_validator)<br>    error_messages        = optional(map(string), {})<br>    validators            = optional(map(string), {})<br>    timeouts = optional(object({<br>      create = optional(string, "30m")<br>      read   = optional(string, "5m")<br>      update = optional(string, "30m")<br>      delete = optional(string, "30m")<br>    }), {})<br>  })</pre> | <pre>{<br>  "error_messages": {<br>    "timeouts": "Timeout object \"%s\" key must be defined as a one to three characters duration string and unit one letter suffix for minutes or hours, ie. 30m, 3h..."<br>  },<br>  "validators": {<br>    "timeouts": "^(\\d{1,3}[m,h])$"<br>  }<br>}</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | The name or UUID for this Management Group, which needs to be unique across your tenant. A new UUID will be generated if not provided. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_parent_group_id"></a> [parent\_group\_id](#input\_parent\_group\_id) | The parent management group ID of the resource group to create. | `string` | `""` | no |
| <a name="input_subscription_ids"></a> [subscription\_ids](#input\_subscription\_ids) | List of subscription IDs to be assigned under management group. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_management_group"></a> [management\_group](#output\_management\_group) | Management Group object |
| <a name="output_management_group_subscription_association"></a> [management\_group\_subscription\_association](#output\_management\_group\_subscription\_association) | Management Group Subscription Association object |
<!-- END_TF_DOCS -->

## Usage

> ADD content