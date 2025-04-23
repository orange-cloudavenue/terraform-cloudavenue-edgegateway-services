<!-- BEGIN_TF_DOCS -->


# Cloudavenue EdgeGateway Service Terraform Module

This Terraform module is designed to manage services on a Cloudavenue Edge Gateway. It provides a simple and flexible way to configure and enable specific services, such as administration and S3, on an edge gateway.

Features:
 - **Edge Gateway Integration**: Attach services to a specified edge gateway using its unique ID.
 - **Firewall Configuration**: Supports multiple firewall modes (bypass, ignore, with create planned for future implementation).
 - **Service Management**: Enable or disable specific services through a customizable configuration.

This module simplifies the management of edge gateway services, ensuring a streamlined and consistent configuration process.

## Example(s)

### Basic usage
```hcl
module "services" {
  source          = "orange-cloudavenue/edgegateway-services/cloudavenue"
  edge_gateway_id = cloudavenue_edgegateway.example.id
}
```

## Disable a service
```hcl
module "services" {
  source          = "orange-cloudavenue/edgegateway-services/cloudavenue"
  edge_gateway_id = cloudavenue_edgegateway.example.id
  services = {
    administration = false
  }
}

```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.0 |
| <a name="requirement_cloudavenue"></a> [cloudavenue](#requirement\_cloudavenue) | >=0.31.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_edge_gateway_id"></a> [edge\_gateway\_id](#input\_edge\_gateway\_id) | The ID of the edge gateway to which the services will be attached. | `string` | n/a | yes |
| <a name="input_firewall"></a> [firewall](#input\_firewall) | The firewall mode for the edge gateway. Can be `bypass`, `ignore`, or `create`. `bypass` means that the firewall is bypassed. `ignore` means that the firewall rules are ignored. `create` means that the firewall rule is created for each services *(create is not implemented yet)*. | `string` | `"bypass"` | no |
| <a name="input_services"></a> [services](#input\_services) | A map of services to be enabled. The keys are the service names and the values are booleans indicating whether the service is enabled or not. | ```object({ administration = optional(bool) s3 = optional(bool) })``` | ```{ "administration": true, "s3": true }``` | no |

## Resources

| Name | Type |
|------|------|
| [cloudavenue_edgegateway_nat_rule.services](https://registry.terraform.io/providers/orange-cloudavenue/cloudavenue/latest/docs/resources/edgegateway_nat_rule) | resource |
| [cloudavenue_edgegateway_services.services](https://registry.terraform.io/providers/orange-cloudavenue/cloudavenue/latest/docs/resources/edgegateway_services) | resource |
<!-- END_TF_DOCS -->
