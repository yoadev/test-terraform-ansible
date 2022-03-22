terraform {
  required_version = ">= 0.12"
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
    local = {
      source = "hashicorp/local"
    }
  }
}

provider "libvirt" {
  uri = var.libvirt_uri
}
