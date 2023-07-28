# PAN-OS Route Azure Service
[![MIT License](https://img.shields.io/badge/license-MIT-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/azurerm/resources/azure/latest/submodules/network_interface)

Terraform module to create and manage a PAN-OS routes to access Azure services.

## Example

```hcl
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    panos = {
      source = "paloaltonetworks/panos"
    }
  }
}

provider "panos" {
}

data "panos_virtual_router" "default" {
  name = "default"
}

variable "interface" {
  type    = string
  default = "ethernet1/1"
}

variable "next_hop" {
  type    = string
  default = "10.120.0.33"
}

variable "services" {
  type    = list(string)
  default = ["Azure Storage", "Power BI"]
}

module "routes-azure" {
  source         = "vmisson/route-azure-service/panos"
  for_each       = toset(var.services)
  interface      = var.interface
  next_hop       = var.next_hop
  service        = each.value
  virtual_router = data.panos_virtual_router.default.name
}
```

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_http"></a> [http](#provider\_http) | n/a |
| <a name="provider_panos"></a> [panos](#provider\_panos) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [panos_static_route_ipv4.this](https://registry.terraform.io/providers/paloaltonetworks/panos/latest/docs/resources/static_route_ipv4) | resource |
| [http_http.this](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bfd_profile"></a> [bfd\_profile](#input\_bfd\_profile) | The BFD profile to use for the static route | `string` | `"None"` | no |
| <a name="input_interface"></a> [interface](#input\_interface) | The interface to use for the static route | `string` | n/a | yes |
| <a name="input_metric"></a> [metric](#input\_metric) | The metric to use for the static route | `number` | `10` | no |
| <a name="input_next_hop"></a> [next\_hop](#input\_next\_hop) | The next hop to use for the static route | `string` | n/a | yes |
| <a name="input_optimized"></a> [optimized](#input\_optimized) | Use optimized count | `bool` | `true` | no |
| <a name="input_service"></a> [service](#input\_service) | The service to use for the static route | `string` | n/a | yes |
| <a name="input_virtual_router"></a> [virtual\_router](#input\_virtual\_router) | The virtual router to use for the static route | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iplist"></a> [iplist](#output\_iplist) | The IP list to use for the static route |
| <a name="output_url"></a> [url](#output\_url) | The URL to use for the static route |
