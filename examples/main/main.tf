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
