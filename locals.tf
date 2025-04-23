locals {
  services = {
    for serviceName, enabled in var.services :
    serviceName => {
      name    = serviceName
      enabled = enabled
      network = cloudavenue_edgegateway_services.services.services[serviceName].network
    }
    if enabled == true
  }
}
