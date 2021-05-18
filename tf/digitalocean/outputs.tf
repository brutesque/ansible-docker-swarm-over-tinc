locals {
  instances = zipmap(digitalocean_droplet.instances.*.name, digitalocean_droplet.instances.*.ipv4_address)
}

resource "local_file" "AnsibleInventory" {
  content = templatefile("${path.module}/ansible-inventory.tmpl",
    {
      instances = local.instances,
    }
  )
  filename = "../secrets/inventory/digitalocean"
}

output "instances" {
  value = local.instances
}
