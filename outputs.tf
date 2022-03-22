output "ips" {
  value = libvirt_domain.domain-debian.*.network_interface
}