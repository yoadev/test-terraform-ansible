resource "libvirt_network" "test_network" {
  # the name used by libvirt
  name = var.net_name

  # mode can be: "nat" (default), "none", "route", "open", "bridge"
  mode = "nat"

  #  the domain used by the DNS server in this network
  domain = var.domain

  #  list of subnets the addresses allowed for domains connected
  # also derived to define the host addresses
  # also derived to define the addresses served by the DHCP server
  addresses = [ var.net_cidr ]

  dns {
    enabled = true
  }
  dhcp {
    enabled = true
  }
}
