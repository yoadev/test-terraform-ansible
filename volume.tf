
resource "libvirt_pool" "debian11" {
  name = "pool01"
  type = "dir"
  path = "/data/libvirtpool/terraform-provider-libvirt-pool-debian"
}

resource "libvirt_volume" "debian_11_image" {
  name   = "debian11.qcow2"
  pool   = libvirt_pool.debian11.name
  source = "https://cloud.debian.org/images/cloud/bullseye/latest/debian-11-genericcloud-amd64.qcow2"
  format = "qcow2"
}

resource "libvirt_volume" "test-os_image" {
  pool           = libvirt_pool.debian11.name
  name           = "test-os_image"
  base_volume_id = libvirt_volume.debian_11_image.id
  size           = var.disk_size == "" ? "0" : var.disk_size
}
