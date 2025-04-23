data "cloudavenue_tier0_vrfs" "example" {}

resource "random_pet" "vdc_name" {
  prefix = "tfmoduletest"
  length = 1
}

resource "cloudavenue_vdc" "example" {
  name                  = random_pet.vdc_name.id
  cpu_allocated         = 22000
  memory_allocated      = 30
  cpu_speed_in_mhz      = 2200
  billing_model         = "PAYG"
  disponibility_class   = "ONE-ROOM"
  service_class         = "STD"
  storage_billing_model = "PAYG"

  storage_profiles = [
    {
      class   = "gold"
      default = true
      limit   = 500
    }
  ]
}

resource "cloudavenue_edgegateway" "example" {
  owner_name     = cloudavenue_vdc.example.name
  tier0_vrf_name = data.cloudavenue_tier0_vrfs.example.names.0
  bandwidth      = 5
}

data "cloudavenue_catalog_vapp_template" "example" {
  catalog_name  = "Orange-Linux"
  template_name = "UBUNTU_24.04"
}

resource "cloudavenue_vapp" "example" {
  name = random_pet.vdc_name.id
  vdc  = cloudavenue_vdc.example.name
}

resource "cloudavenue_vm" "example" {
  name      = random_pet.vdc_name.id
  vapp_name = cloudavenue_vapp.example.name
  vdc       = cloudavenue_vdc.example.name

  deploy_os = {
    vapp_template_id = data.cloudavenue_catalog_vapp_template.example.id
  }

  settings = {
    customization = {
      enabled     = true
      init_script = <<-EOT
        #!/bin/sh
        cloud-init clean --machine-id
        reboot -h now
      EOT
    }

    guest_properties = {
      "instance-id"    = "${random_pet.vdc_name.id}"
      "local-hostname" = "${random_pet.vdc_name.id}"
      "user-data"      = base64encode(templatefile("./cloud-init.tmpl", { user = var.username, ssh_key = var.ssh_public_key }))
    }
  }

  resource = {
    cpus   = 2
    memory = 2048
    networks = [
      {
        type               = "org"
        name               = cloudavenue_vapp_org_network.example.network_name
        ip                 = "192.168.1.11"
        ip_allocation_mode = "MANUAL"
        is_primary         = true
      }
    ]
  }

  state = {
    power_on = true
  }
}

resource "cloudavenue_publicip" "example" {
  edge_gateway_id = cloudavenue_edgegateway.example.id
}

resource "cloudavenue_edgegateway_network_routed" "example" {
  name = random_pet.vdc_name.id

  edge_gateway_id = cloudavenue_edgegateway.example.id

  gateway       = "192.168.1.254"
  prefix_length = 24

  dns1 = "1.1.1.1"
  dns2 = "8.8.8.8"


  static_ip_pool = [
    {
      start_address = "192.168.1.10"
      end_address   = "192.168.1.20"
    }
  ]
}

resource "cloudavenue_vapp_org_network" "example" {
  vapp_name    = cloudavenue_vapp.example.name
  network_name = cloudavenue_edgegateway_network_routed.example.name
  vdc          = cloudavenue_vdc.example.name
}

data "cloudavenue_edgegateway_app_port_profile" "ssh" {
  name            = "SSH"
  edge_gateway_id = cloudavenue_edgegateway.example.id
}

// NAT rule to allow access to the VM from the public IP via SSH
resource "cloudavenue_edgegateway_nat_rule" "example" {
  edge_gateway_id = cloudavenue_edgegateway.example.id

  name        = "SSH"
  description = "SSH access to VM"

  rule_type           = "DNAT"
  firewall_match      = "BYPASS"
  dnat_external_port  = 45876
  external_address    = cloudavenue_publicip.example.public_ip
  internal_address    = cloudavenue_vm.example.resource.networks[0].ip
  app_port_profile_id = data.cloudavenue_edgegateway_app_port_profile.ssh.id
}

// SNAT rule to allow access to the internet from the VM
resource "cloudavenue_edgegateway_nat_rule" "INTERNET" {
  edge_gateway_id = cloudavenue_edgegateway.example.id

  name        = "SNAT"
  description = "SNAT rule for internet access"

  rule_type      = "SNAT"
  firewall_match = "BYPASS"

  external_address = cloudavenue_publicip.example.public_ip
  internal_address = "0.0.0.0/0"

  priority = 100
}

module "services" {
  source          = "../../"
  edge_gateway_id = cloudavenue_edgegateway.example.id
}
