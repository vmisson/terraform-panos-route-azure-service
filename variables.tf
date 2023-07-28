variable "service" {
  description = "The service to use for the static route"
  type        = string
}

variable "virtual_router" {
  description = "The virtual router to use for the static route"
  type        = string
}

variable "interface" {
  description = "The interface to use for the static route"
  type        = string
}

variable "next_hop" {
  description = "The next hop to use for the static route"
  type        = string
}

variable "metric" {
  description = "The metric to use for the static route"
  type        = number
  default     = 10
}

variable "optimized" {
    description = "Use optimized count"
    type = bool
    default = true
}

variable "bfd_profile" {
  description = "The BFD profile to use for the static route"
  type        = string
  default     = "None"
}
