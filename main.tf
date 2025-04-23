resource "cloudavenue_edgegateway_services" "services" {
  edge_gateway_id = var.edge_gateway_id
}

resource "cloudavenue_edgegateway_nat_rule" "services" {
  // Explicit dependency on the services resource to ensure that the NAT rule is
  // deleted before the services resource.
  depends_on = [cloudavenue_edgegateway_services.services]
  for_each   = local.services

  edge_gateway_id = var.edge_gateway_id
  name            = "Cloudavenue Service ${each.value.name}"

  rule_type                = "SNAT"
  external_address         = cloudavenue_edgegateway_services.services.ip_address
  internal_address         = "0.0.0.0/0"
  snat_destination_address = each.value.network
  priority                 = 0

  firewall_match = var.firewall == "bypass" ? "BYPASS" : "MATCH_INTERNAL_ADDRESS"
}
