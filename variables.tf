variable "edge_gateway_id" {
  type        = string
  description = "The ID of the edge gateway to which the services will be attached."
  nullable    = false
}

variable "firewall" {
  type        = string
  default     = "bypass"
  description = "The firewall mode for the edge gateway. Can be `bypass`, `ignore`, or `create`. `bypass` means that the firewall is bypassed. `ignore` means that the firewall rules are ignored. `create` means that the firewall rule is created for each services *(create is not implemented yet)*."
  validation {
    condition     = alltrue([contains(["bypass", "ignore"], var.firewall)]) // TODO : add create
    error_message = "The firewall must be set to bypass or ignore."
  }
}
variable "services" {
  type = object({
    administration = optional(bool)
    s3             = optional(bool)
  })
  default = {
    administration = true
    s3             = true
  }
  description = "A map of services to be enabled. The keys are the service names and the values are booleans indicating whether the service is enabled or not."
}
