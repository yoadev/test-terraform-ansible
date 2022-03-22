resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/template/inventory.cfg",
    {
     vm_ip = libvirt_domain.domain-debian.network_interface.0.addresses.0,
     vm_name = var.hostname,
     vm_pkey = var.private_key_path
    }
  )
  filename = "./ansible_inventory.ini"
}
