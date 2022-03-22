# vm memory
variable "memoryMB" {
  default = 1024 * 1
}
# vm cpu
variable "cpu" {
  default = 1
}
# vm disk
variable "disk_size" {
  default = 8 * 1024 * 1024 * 1024
}

variable "libvirt_uri" {
  description = "qemu uri connection"
  default     = "qemu:///system"
  #"qemu+ssh://root@192.168.x.x/system"
}

variable "libvirt_pool_dir" {
  default = "/data/libvirtpool/terraform-provider-libvirt-pool-debian"
}

variable "libvirt_pool_name" {
  default = "pool01"
}

variable "private_key_path" {
  description = "Path to the private SSH key, used to access the instance."
  default     = "~/.ssh/id_rsa"
}

variable "public_key_path" {
  description = "Path to the public SSH key"
  default     = "~/.ssh/id_rsa.pub"
}
# vm hostname
variable "hostname" {
  default = "simplevm"
}
# dns vm domain
variable "domain" {
  default = "testvm.local"
}
# vm timezone
variable "timezone" {
  default = "Europe/Paris"
}
# libvirt vm network name
variable "net_name" {
  default = "testnet"
}
# network vm type
variable "ip_type" {
  default = "dhcp"
}
# dhcp network slice
variable "net_cidr" {
  default = "10.17.3.0/24"
}
