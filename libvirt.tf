
// Using CloudInit ISO (debian 11)

resource "libvirt_cloudinit_disk" "commoninit" {
  name           = "${var.hostname}-commoninit.iso"
  pool           = libvirt_pool.debian11.name
  user_data      = data.template_cloudinit_config.config.rendered
  network_config = data.template_file.network_config.rendered
}

data "template_file" "user_data" {
  template = file("${path.module}/template/cloud_init.cfg")
  vars = {
    hostname   = var.hostname
    fqdn       = "${var.hostname}.${var.domain}"
    domain     = var.domain
    timezone   = var.timezone
    public_key = file(var.public_key_path)
  }
}

data "template_cloudinit_config" "config" {
  gzip          = false
  base64_encode = false
  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.user_data.rendered
  }
}

data "template_file" "network_config" {
  template = file("${path.module}/template/network_config_${var.ip_type}.cfg")
}

// Create VM

resource "libvirt_domain" "domain-debian" {
  name       = var.hostname
  memory     = var.memoryMB
  vcpu       = var.cpu
  autostart  = true
  qemu_agent = true
  cloudinit = libvirt_cloudinit_disk.commoninit.id

  timeouts {
    create = "5m"
  }

  disk {
    volume_id = libvirt_volume.test-os_image.id
  }
  
  network_interface {
    network_name = libvirt_network.test_network.name
    wait_for_lease = true
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = "true"
  }

  provisioner "remote-exec" {
    inline = [
      "cloud-init status --wait",
    ]

    connection {
      host     = "${self.network_interface.0.addresses.0}"
      type     = "ssh"
      user     = "ansible"
      private_key = "${file(var.private_key_path)}"
    }
  }

  // First ansible provision ( lang, keyboard and apt upgrade)
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -v -D -u ansible -i ${self.network_interface.0.addresses.0}, --private-key ${var.private_key_path} provision/play_provision.yml"
  }
}
