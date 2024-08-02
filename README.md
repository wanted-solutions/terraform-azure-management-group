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
| <a name="provider_consul"></a> [consul](#provider\_consul) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_consumption_budget_management_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/consumption_budget_management_group) | resource |
| [azurerm_management_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group) | resource |
| [azurerm_management_group_subscription_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_group_subscription_association) | resource |
| [consul_keys.metadata](https://registry.terraform.io/providers/hashicorp/consul/latest/docs/data-sources/keys) | data source |
| [local_file.metadata](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_budgets"></a> [budgets](#input\_budgets) | List of budgets to be assigned under management group. | <pre>list(object({<br>    name       = string<br>    amount     = number<br>    time_grain = string<br>    start_date = string<br>    end_date   = string<br>    filter = object({<br>      dimension = list(object({<br>        name   = string<br>        values = list(string)<br>      }))<br>      tag = list(object({<br>        name   = string<br>        values = list(string)<br>      }))<br>    })<br>    notifications = list(object({<br>      enabled        = bool<br>      threshold      = number<br>      operator       = string<br>      threshold_type = string<br>      contact_emails = list(string)<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | A friendly name for this Management Group. If not specified, this will be the same as the "name" variable. | `string` | `""` | no |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | Module metadata object to give user possibility to override default module values. | <pre>object({<br>    module_external_metadata = optional(object({<br>      format = optional(string, "json")<br>      source = optional(string, "file")<br>    }), {})<br>    resource_timeouts = optional(map(object({<br>      create = optional(string)<br>      read   = optional(string)<br>      update = optional(string)<br>      delete = optional(string)<br>    })), {})<br>    validator_error_messages = optional(map(string), {})<br>    validator_expressions    = optional(map(string), {})<br>  })</pre> | <pre>{<br>  "module_external_metadata": {<br>    "format": "json",<br>    "source": "file"<br>  }<br>}</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | The name or UUID for this Management Group, which needs to be unique across your tenant. A new UUID will be generated if not provided. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_parent_group_id"></a> [parent\_group\_id](#input\_parent\_group\_id) | The parent management group ID of the resource group to create. | `string` | `""` | no |
| <a name="input_subscription_ids"></a> [subscription\_ids](#input\_subscription\_ids) | List of subscription IDs to be assigned under management group. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_management_group"></a> [management\_group](#output\_management\_group) | Management Group object |
| <a name="output_management_group_subscription_association"></a> [management\_group\_subscription\_association](#output\_management\_group\_subscription\_association) | Management Group Subscription Association object |
| <a name="output_metadata"></a> [metadata](#output\_metadata) | Module metadata object |
<!-- END_TF_DOCS -->

## Usage

> ADD content