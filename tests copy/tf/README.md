# tf

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_cloudavenue"></a> [cloudavenue](#requirement\_cloudavenue) | >= 0.31.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.5.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudavenue"></a> [cloudavenue](#provider\_cloudavenue) | 0.31.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_services"></a> [services](#module\_services) | ../../ | n/a |

## Resources

| Name | Type |
|------|------|
| [cloudavenue_edgegateway.example](https://registry.terraform.io/providers/orange-cloudavenue/cloudavenue/latest/docs/resources/edgegateway) | resource |
| [cloudavenue_edgegateway_nat_rule.INTERNET](https://registry.terraform.io/providers/orange-cloudavenue/cloudavenue/latest/docs/resources/edgegateway_nat_rule) | resource |
| [cloudavenue_edgegateway_nat_rule.example](https://registry.terraform.io/providers/orange-cloudavenue/cloudavenue/latest/docs/resources/edgegateway_nat_rule) | resource |
| [cloudavenue_edgegateway_network_routed.example](https://registry.terraform.io/providers/orange-cloudavenue/cloudavenue/latest/docs/resources/edgegateway_network_routed) | resource |
| [cloudavenue_publicip.example](https://registry.terraform.io/providers/orange-cloudavenue/cloudavenue/latest/docs/resources/publicip) | resource |
| [cloudavenue_vapp.example](https://registry.terraform.io/providers/orange-cloudavenue/cloudavenue/latest/docs/resources/vapp) | resource |
| [cloudavenue_vapp_org_network.example](https://registry.terraform.io/providers/orange-cloudavenue/cloudavenue/latest/docs/resources/vapp_org_network) | resource |
| [cloudavenue_vdc.example](https://registry.terraform.io/providers/orange-cloudavenue/cloudavenue/latest/docs/resources/vdc) | resource |
| [cloudavenue_vm.example](https://registry.terraform.io/providers/orange-cloudavenue/cloudavenue/latest/docs/resources/vm) | resource |
| [random_pet.vdc_name](https://registry.terraform.io/providers/hashicorp/random/3.5.1/docs/resources/pet) | resource |
| [cloudavenue_catalog_vapp_template.example](https://registry.terraform.io/providers/orange-cloudavenue/cloudavenue/latest/docs/data-sources/catalog_vapp_template) | data source |
| [cloudavenue_edgegateway_app_port_profile.ssh](https://registry.terraform.io/providers/orange-cloudavenue/cloudavenue/latest/docs/data-sources/edgegateway_app_port_profile) | data source |
| [cloudavenue_tier0_vrfs.example](https://registry.terraform.io/providers/orange-cloudavenue/cloudavenue/latest/docs/data-sources/tier0_vrfs) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | SSH public key | `string` | n/a | yes |
| <a name="input_username"></a> [username](#input\_username) | Username | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_vm_public_ip"></a> [vm\_public\_ip](#output\_vm\_public\_ip) | n/a |
<!-- END_TF_DOCS -->
