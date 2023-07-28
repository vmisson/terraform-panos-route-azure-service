terraform {
  required_providers {
    panos = {
      source = "paloaltonetworks/panos"
    }
  }
}

locals {
  service = replace(lower(var.service), " ", "")
  url     = "https://saasedl.paloaltonetworks.com/${var.optimized ? "feeds" : "original"}/azure/public/${local.service}/ipv4"
  iplist  = compact(split("\n", data.http.this.response_body))
}

data "http" "this" {
  url = local.url
}

resource "panos_static_route_ipv4" "this" {
  for_each       = toset(local.iplist)
  name           = "${local.service}-${replace(each.value, "/", "_")}"
  virtual_router = var.virtual_router
  destination    = each.value
  next_hop       = var.next_hop
  interface      = var.interface
  metric         = var.metric
  bfd_profile    = var.bfd_profile
}