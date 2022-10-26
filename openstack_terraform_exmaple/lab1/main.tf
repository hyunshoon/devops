terraform {
  required_providers {
    libvirt = {
      source = "multani/libvirt"
      version = "0.6.3-1+4"
    }
  }
}

provider "libvirt" {
  alias = "hypervisor"
  uri = "qemu+ssh://root@hypervisor/system"
}
